module.exports = {
  env: {
    browser: false,
    es6: true,
    node: true
  },
  parserOptions: {
    sourceType: "module",
    ecmaVersion: 2017
  },
  extends: ["eslint:recommended"],
  rules: {
    "new-cap": "off",
    "no-console": "off",
    camelcase: "off",
    "no-return-await": "off",
    eqeqeq: "off"
  },
  globals: {
    jest: true,
    describe: true,
    test: true,
    expect: true,
    $: true,
    Prism: true,
    mermaid: true,
    localforage: true,
    document: true
  }
};
