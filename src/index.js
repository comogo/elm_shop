if (module.hot) {
  module.hot.dispose(() => {
    window.location.reload();
  });
}

import('./elm/Main.elm')
  .then(({ Elm }) => {
    Elm.Main.init({ node: document.getElementById("main") });
  });
