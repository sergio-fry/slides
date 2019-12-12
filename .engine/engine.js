const { Marp } = require('@marp-team/marp-core')

module.exports = function(opts) {
  opts['html'] = true;

  plantUmlOptions = {}

  return new Marp(opts).use(require('markdown-it-plantuml'), plantUmlOptions);
}
