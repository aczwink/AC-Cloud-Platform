const path = require("path");
const TerserPlugin = require("terser-webpack-plugin");

module.exports = {
    target: "node",
  
    entry: {
        index: "./index.js"
    },
  
    output: {
        path: path.resolve(__dirname, "dist"),
        chunkFilename: "[name].js",
        filename: "[name].js",
        libraryTarget: "commonjs2"
    },
  
    mode: "production",
  
    resolve: {
        extensions: [".js"]
    },
  
    externals: {
    },
  
    optimization: {
        minimize: true,
        minimizer: [
            new TerserPlugin({
                terserOptions: {
                    compress: false,
                    mangle: false,
                    format: {
                        comments: false,
                        beautify: false
                    }
                },
                extractComments: false
            })
        ]
    }
};