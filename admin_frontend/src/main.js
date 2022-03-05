import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import naive from "naive-ui";
import authConfig from "../auth_config.json";
import { setupAuth } from "./auth";

let app = createApp(App).use(store).use(router).use(naive);

// callbackRedirect and setupAuth source: https://github.com/lstyles/vue3-auth0-sample
function callbackRedirect(appState) {
  router.push(
    appState && appState.targetUrl
      ? appState.targetUrl
      : '/'
  );
}

setupAuth(authConfig, callbackRedirect).then((auth) => {
  app.use(auth).mount('#app');
})