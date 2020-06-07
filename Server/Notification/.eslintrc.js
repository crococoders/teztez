module.exports = {
  extends: ['@anvilabs/eslint-config', '@anvilabs/eslint-config-typescript'],
  plugins: ['import-helpers', 'react-hooks'],
  settings: {
    react: {
      version: '16.7.7',
    },
  },
  rules: {
    // https://eslint.org/docs/rules
    // disable some irrelevant rules
    'lines-between-class-members': 'off',
    'max-nested-callbacks': 'off',
    'no-magic-numbers': [
      'warn',
      {
        ignore: [-1, 0, 0.5, 1, 2],
        ignoreArrayIndexes: true,
        enforceConst: true,
        detectObjects: false,
      },
    ],
    'no-use-before-define': 'off',

    // https://github.com/benmosher/eslint-plugin-import
    // disable some irrelevant rules
    'import/dynamic-import-chunkname': 'off',
    'import/exports-last': 'off',
    // suppress errors for `.mjs` extension
    'import/extensions': [
      'error',
      'always',
      {
        js: 'never',
        mjs: 'never',
        ts: 'never',
        tsx: 'never',
      },
    ],

    // https://github.com/Tibfib/eslint-plugin-import-helpers
    // order imports by group
    'import-helpers/order-imports': [
      'warn',
      {
        'newlines-between': 'always',
        groups: [
          'builtin',
          'external',
          'internal',
          ['parent', 'sibling', 'index'],
        ],
        alphabetize: {order: 'ignore'},
      },
    ],

    // https://github.com/sindresorhus/eslint-plugin-unicorn
    // disable some irrelevant rules
    'unicorn/no-fn-reference-in-iterator': 'off',

    // https://github.com/typescript-eslint/typescript-eslint/tree/master/packages/eslint-plugin
    // disable some irrelevant rules
    '@typescript-eslint/camelcase': 'off',

    // https://github.com/facebook/react/tree/master/packages/eslint-plugin-react-hooks
    'react-hooks/rules-of-hooks': 'error',
    'react-hooks/exhaustive-deps': 'warn',
  },
  overrides: [
    {
      files: ['*.js', '**/.*.js', '**/scripts/*.ts'],
      ...require('@anvilabs/eslint-config/script'),
    },
    {
      files: ['*.d.{ts,tsx}'],
      rules: {
        // https://eslint.org/docs/rules
        // disable rules that don't make sense in dts files
        'no-redeclare': 'off',

        // https://github.com/typescript-eslint/typescript-eslint/tree/master/packages/eslint-plugin
        // disable rules that don't make sense in dts files
        '@typescript-eslint/explicit-member-accessibility': 'off',
        '@typescript-eslint/no-extraneous-class': 'off',
      },
    },
  ],
};
