// eslint-disable-next-line no-undef
module.exports = {
  parser: "@typescript-eslint/parser",
  extends: [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended"
  ],
  parserOptions: {
    project: "tsconfig.test.json"
  },
  plugins: [
    "@typescript-eslint",
    "@stylistic/ts"
  ],
  rules: {
    "indent": "off",
    "@stylistic/ts/indent": ["error", 2],
    "@stylistic/ts/semi": ["error", "never"],
    "@stylistic/ts/quotes": ["error", "double"],
    "@typescript-eslint/strict-boolean-expressions": ["error", {
      "allowNumber": false,
      "allowString": false,
      "allowNullableObject": false
    }],
    "@typescript-eslint/no-explicit-any": "error",
    "no-restricted-syntax": [
      "error",
      {
        selector: "FunctionDeclaration > Identifier[optional=true]",
        message: "Optionals are not allowed. Replace with type union undefined",
        /*fix(fixer) {
          return fixer.replaceText(
            this.node.parent.params[this.node.parent.params.indexOf(this.node)],
            `${this.source}?: number|undefined`
          );
        }*/
      }
    ]
  }
}