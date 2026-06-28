const path = require("path");

module.exports = {
    target: "node",
  
    entry: require.resolve("serve/build/main.js"),
  
    output: {
        path: path.resolve(__dirname, "dist"),
        filename: "[name].js"
    },
  
    mode: "production",
  
    optimization: {
        minimize: true,
    }
};