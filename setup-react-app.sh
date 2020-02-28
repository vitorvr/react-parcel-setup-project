#!/bin/bash
echo ">> Setting up YARN...";
yarn init --yes;

echo ">> Running YARN install...";
yarn add parcel-bundler -D;
yarn add @babel/core;
yarn add @babel/preset-env;
yarn add @babel/preset-react;
yarn add @babel/plugin-proposal-class-properties -D;
yarn add react react-dom;
yarn add @babel/polyfill;

echo ">> Setting up initial files...";

# .babelrc
echo '{
  "presets": ["@babel/preset-env", "@babel/preset-react"],
  "plugins": ["@babel/plugin-proposal-class-properties"]
}
' >> .babelrc;

# Setup directories
mkdir src;

# index.html
echo '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta
      name="viewport"
      content="minimum-scale=1, initial-scale=1, width=device-width, shrink-to-fit=no"
    />
    <title>React Parcel Starter</title>
  </head>
  <body>
    <div id="root"></div>
    <script src="index.js"></script>
  </body>
</html>
' >> src/index.html;

# src/index.js
echo "import React from \"react\";
import ReactDOM from \"react-dom\";
import App from \"./App.js\";
import \"@babel/polyfill\";

ReactDOM.render(<App />, document.getElementById(\"root\"));" >> src/index.js;

# src/App.js
echo "import React from \"react\";
const App = () => {
  return (
    <div>
      <h1>React Parcel Starter</h1>
    </div>
  );
};
export default App;" >> src/App.js;

sed -i '$s/}/,  "scripts": {\n    "dev": "parcel \.\/src\/index.html",\n    "build": "parcel build .\/src\/index.html"\n  }\n}/' package.json;
jq . package.json > package-new.json;
rm -rf package.json;
mv package-new.json package.json