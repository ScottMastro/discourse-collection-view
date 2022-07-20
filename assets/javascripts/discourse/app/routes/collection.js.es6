import DiscourseRoute from "discourse/routes/discourse";
import { ajax } from "discourse/lib/ajax";
import { popupAjaxError } from "discourse/lib/ajax-error";
import User from "discourse/models/user";

export default DiscourseRoute.extend({
    model(params) {
      return ajax(`/collection/${params.id}.json`)
        .then((result) => {
          return result;
        }).catch(popupAjaxError);
    }
});