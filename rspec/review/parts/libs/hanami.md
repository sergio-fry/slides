
```ruby

  it "renders <video> tag" do
    actual = video_tag("movie.mp4").to_s
    expect(actual).to eq(%(<video src="/assets/movie.mp4"></video>))
  end
```
https://github.com/hanami/hanami/blob/a2bdb77f10d7873e0685f47317583a581f382d02/spec/unit/hanami/helpers/assets_helper/video_tag_spec.rb

