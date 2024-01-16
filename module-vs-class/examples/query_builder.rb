module Api
  module V1
    module QueryBuilders
      class IndexQueryBuilder
        include IndexQueryParamsParts

        attr_reader :params, :forms, :fields

        def self.call(params)
          new(params).call
        end

        def initialize(params)
          @params = params.with_indifferent_access
          @fields = CashCore::Field.arel_table
          @forms = CashCore::Form.arel_table
        end

        def call
          builded_search_query
        end

        private

        def builded_search_query
          select_fields_query.take(page_size)
        end

        def select_fields_query
          return sales_channel_id_query unless owner_query.present?

          fields_query= Arel::SelectManager.new(CashCore::Field.arel_table)
            .project(fields[:form_id])
            .where(owner_query)

          sales_channel_id_query.where(forms[:id].in(fields_query))
        end

        def search_query
          return unless params[:search] && search_params.length >= 3

          value = Arel::Nodes::SqlLiteral.new("((value #>> '{}'::text[]))")

          value.matches("%#{search_params}%").and(fields[:name].in(field_names))
        end

        def owner_query
          return search_query unless params[:owner]

          value = Arel::Nodes::SqlLiteral.new("(value #>> '{}')::integer")
          owner = fields[:name].eq('gatekeeper_id_on_update').and(value.eq(params[:gatekeeper_id]))

          search_query.present? ? search_query.or(owner) : owner
        end

        def base_query
          Arel::SelectManager.new(CashCore::Form.arel_table)
            .project(forms[:id])
            .order(forms[:updated_at].desc)
        end

        def form_type_query
          return base_query unless params[:form_type_name].present?

          form_type = CashCore::FormType.find_by(name: params[:form_type_name])
          base_query.where(forms[:form_type_id].eq(form_type.id))
        end

        def form_status_query
          return form_type_query unless params[:form_status]

          form_type_query.where(forms[:form_status].in(params[:form_status].split(',')))
        end

        def urm_code_query
          return form_status_query unless params[:urm_code]

          form_status_query.where(forms[:urm_code].eq(params[:urm_code]))
        end

        def updated_at_query
          return urm_code_query unless updated_at_params

          query = urm_code_query
          query = query.where(forms[:updated_at].gteq(Time.parse(min_time))) if min_time
          query = query.where(forms[:updated_at].lt(Time.parse(max_time))) if max_time

          query
        end

        def last_sortable_values_query
          return updated_at_query unless last_sortable_values

          query = updated_at_query
          query = query.where(forms[:created_at].lt(Time.parse(created_time))) if created_time
          query = query.where(forms[:updated_at].lt(Time.parse(updated_time))) if updated_time
          query
        end

        def sales_channel_id_query
          return last_sortable_values_query unless params[:sales_channel_id]

          last_sortable_values_query
            .where(forms[:sales_channel_id].eq(params[:sales_channel_id].to_i))
        end
      end
    end
  end
end

      module IndexQueryParamsParts
        DEFAULT_PAGE_SIZE = 100

        def min_time
          params.dig(:updated_at, :min)
        end

        def max_time
          params.dig(:updated_at, :max)
        end

        def updated_at_params
          params[:updated_at]
        end

        def page_size
          params[:page_size] ? params[:page_size].to_i : DEFAULT_PAGE_SIZE
        end

        def field_names
          @field_names ||= Field.where(searchable: true).pluck(:name).map(&:to_s)
        end

        def search_params
          # TODO: поставить задачу на фронт, что бы не присылали *
          params[:search].gsub('*', '')
        end

        def sales_channel_ids
          params[:sales_channel_id].split(',')
        end

        def min_form_id
          CashCore::Form.where('updated_at >= ?', 2.month.ago.to_s).minimum(:id)
        end

        def min_field_id
          Rails.cache.fetch('IndexQueryBuilder/min_field_id', expires_in: 10.minutes) do
            CashCore::Field.where(form_id: min_form_id).minimum(:id)
          end
        end

        def last_sortable_values
          params[:last_sortable_values]
        end

        def created_time
          params[:last_sortable_values][:created_at]
        end

        def updated_time
          params[:last_sortable_values][:updated_at]
        end
      end
