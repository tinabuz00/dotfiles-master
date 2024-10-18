; after/queries/python/injections.scm
;extends

(module
  (expression_statement
    (string
      (string_content) @injection.content)
    )
  (#set! injection.language "markdown")
)


