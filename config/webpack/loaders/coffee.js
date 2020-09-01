module.exports = {
  test: /\.coffee(\.erb)?$/,
  use: [{
    loader: 'coffee-loader'
  }, {
    loader: 'sass-loader'
  }]
}
