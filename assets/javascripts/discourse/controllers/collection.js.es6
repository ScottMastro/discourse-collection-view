import Controller from "@ember/controller";

export default Controller.extend({

  init() {
    this._super(...arguments);
  },

  actions: {
    selectItem(post_id){

      for (let i = 0; i < this.model.posts.length; i++) {
        if (this.model.posts[i].id == post_id){

          const id = "post-num-"+this.model.posts[i].id;
          const yOffset = -60; 
          const element = document.getElementById(id);
          const y = element.getBoundingClientRect().top + window.pageYOffset + yOffset;
          
          window.scrollTo({top: y, behavior: 'smooth'});

        }
      }
    },
  }
});
