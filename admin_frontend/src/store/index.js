import { createStore } from 'vuex'

export default createStore({
  state() {
    return {
      userId: null
    }
  },
  mutations: {
    setUserId(state, userId){
      state.userId = userId
    }
  },
  actions: {
  },
  modules: {
  }
})
