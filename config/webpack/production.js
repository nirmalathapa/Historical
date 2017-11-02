const environment = require('./environment')

const merge = require('webpack-merge')
const customConfig = require('./shared')

module.exports = merge(environment.toWebpackConfig(), customConfig)
