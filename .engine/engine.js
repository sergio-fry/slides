const { Marp } = require('@marp-team/marp-core')


// TODO: add code snippets lines
// https://github.com/orgs/marp-team/discussions/164?ysclid=lovarg4cb969872172

   //"@kazumatu981/markdown-it-kroki": "^1.3.4",
   //"@marp-team/marp-cli": "^4.1.2",
   //"@marp-team/marp-core": "^4.0.0",
   //"markdown-it-include": "^2.0.0",
   //"uri-js": "^4.4.1"
module.exports = function(opts) {
  opts['html'] = true;

  return new Marp(opts).
        use(require('markdown-it-include')).
        use(require('@kazumatu981/markdown-it-kroki'), {
          entrypoint: "https://kroki.io",
        });
}
