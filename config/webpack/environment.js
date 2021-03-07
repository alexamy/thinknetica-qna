const { environment } = require('@rails/webpacker')

environment.loaders.append('expose', {
  test: require.resolve('cash-dom'),
  loader: 'expose-loader',
  options: {
    exposes: '$'
  }
});

module.exports = environment
