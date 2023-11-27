// eslint-disable-next-line no-undef
module.exports = {
  parser: "@typescript-eslint/parser",
  extends: [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended",
  ],
  parserOptions: {
    project: "tsconfig.test.json",
  },
  plugins: [
    "@typescript-eslint",
    "@stylistic/ts",
    "unused-imports",
  ],
  rules: {
    "indent": "off",
    "@stylistic/ts/indent": ["error", 2],
    "@stylistic/ts/semi": ["error", "never"],
    "@stylistic/ts/quotes": ["error", "double"],
    "@stylistic/ts/comma-dangle": ["error", "only-multiline"],
    "no-trailing-spaces": ["error"],
    "@typescript-eslint/strict-boolean-expressions": ["error", {
      "allowNumber": false,
      "allowString": false,
      "allowNullableObject": false,
    }],
    "@typescript-eslint/no-explicit-any": "error",
    "@typescript-eslint/consistent-type-imports": ["error", {
      prefer: "type-imports",
      disallowTypeAnnotations: true,
      fixStyle: "inline-type-imports",
    }],
    "no-unused-vars": "off",
    "@typescript-eslint/no-unused-vars": "off",
    "unused-imports/no-unused-imports": "error",
    "unused-imports/no-unused-vars": [
      "warn",
      { "vars": "all", "varsIgnorePattern": "^_", "args": "after-used", "argsIgnorePattern": "^_" },
    ],
    "no-restricted-syntax": [
      "error",
      {
        selector: "FunctionDeclaration > Identifier[optional=true]",
        message: "Optionals are not allowed. Replace with type union undefined",
      },
    ],
  },
}