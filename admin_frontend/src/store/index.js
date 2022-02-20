import { createStore } from 'vuex'

export default createStore({
  state() {
    return {
      userId: null,
      projectDetailsChanged: false
    }
  },
  mutations: {
    setUserId(state, userId){
      state.userId = userId
    },

    toggleProjectDetailsChanged(state){
      state.projectDetailsChanged = !state.projectDetailsChanged;
    }

  },
  actions: {
  },
  modules: {
  }
})
