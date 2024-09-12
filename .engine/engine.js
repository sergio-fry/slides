const { Marp } = require('@marp-team/marp-core')


// TODO: add code snippets lines
// https://github.com/orgs/marp-team/discussions/164?ysclid=lovarg4cb969872172

module.exports = function(opts) {
  opts['html'] = true;

  return new Marp(opts).
        use(require('markdown-it-include')).
        use(require('@kazumatu981/markdown-it-kroki'), {
          entrypoint: "https://kroki.io",
        });
}
