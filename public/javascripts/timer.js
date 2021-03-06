function pad(str) {
  if (str.toString) str = str.toString();
  if (str.length < 2) {
    (2 - str.length).times(function() {
      str = "0" + str;
    });
  }
  return str;
}

function parseTime(time_diff, parts) {
  var hrs = parseInt(time_diff / (1000 * 60 * 60)),
      left = time_diff % (1000 * 60 * 60);

  var mins = parseInt(left / (1000 * 60)),
      left = left % (1000 * 60);

  var secs = parseInt(left / 1000);
  var res = [hrs, mins, secs].map(pad).join(":");

  if (typeof parts != "undefined") {
    var parts = left % 1000
    res = res + "." + pad(parseInt(parts / 10));
  }

  return res;
}

var Timer = Class.create({
  initialize : function(element, id, start_time) {
    this.element = $(element);
    this.results = [];
    if (typeof id != "undefined") this.timer_id = id;
    if (typeof start_time != "undefined") this.start_time = start_time;
    if (this.timer_id) {
      this.getResults();
      this.updateNames();
    }
  },
  getResults : function() {
    if (this.updating) return;
    this.updating = true;
    new Ajax.Request('/timers/' + this.timer_id + "/results.json", {
      method : 'GET',
      onSuccess : function(resp) {
        var new_results = resp.responseJSON;

        // console.log("new results: ", new_results.size());

        this.results = this.results.concat(new_results);

        // console.log("this.results: ", this.results)

        new_results.each(function(result) {
          var new_el = this.listElement(result);
          new_el.id = 'result_' + result.id;

          if (result["bib_number"]) {
            new_el.insert({bottom : " " + result["bib_number"]});
          }

          if (result["name"]) {
            new_el.insert({bottom : " " + result["name"]});
          }
          if (result["category_name"]) {
            new_el.insert({bottom : " " + result["category_name"]});
          }
          $('results').insert({
            bottom: new_el
          });
        }.bind(this));

        if (new_results.size() > 0) {
          //$('result_' + new_results.first().id).down('input[type=text]').select();
          //window.location = window.location.pathname + "#list_end";
          Event.addBehavior.reload();
        }
        this.updating = false;
      }.bind(this),
      onFailure: function(resp) {
        this.updating = false;
      },
    });
  },
  updateTime : function() {
    var cur = new Date().getTime();
    this.element.innerHTML = '';
    this.element.update(parseTime(this.getTimeDiff(cur)));
  },
  getTimeDiff : function(cur) {
    return cur - this.start_time;
  },
  reset : function() {
    this.start_time = new Date().getTime();
    this.updateTime();
    $('results').innerHTML = '';
    this.reseted = true;
  },
  start : function() {
    if (this.pe) return;
    if (typeof this.start_time == "undefined" || this.reseted) {
      this.start_time = new Date().getTime();

      new Ajax.Request('/timers.json', {
        onSuccess: function(res) {
          var id = res.responseJSON['id'];
          this.timer_id = id;
          window.history.replaceState({}, "", "/timers/" + id);
          this.getResults();
        }.bind(this),
        method : 'POST',
        parameters : { 'timer[start_time]' : this.start_time },
      });

      this.reseted = false;
    }
    this.pe = new PeriodicalExecuter(this.updateTime.bind(this), 1);
    this.updateNames();
  },
  stop : function() {
    if (this.pe) {
      this.pe.stop();
      this.nameUpdater.stop();
      this.pe = null;
    }
  },
  storeResult : function() {
    if (typeof this.start_time == "undefined" || this.reseted) return false;
    var res = this.getTimeDiff(new Date().getTime());
    var result = {'result': res}
    this.results.push(result);
    //this.refreshResultList();
    var el = this.listElement(result);
    $('results').insert({ bottom : el.highlight() });

    new Ajax.Request('/results.json', {
      onSuccess: function(res) {
        var id = res.responseJSON['id'];
        el.writeAttribute('id', 'result_' + id);
        el.writeAttribute('title', id);
        result['id'] = id;
      },
      method : 'POST',
      parameters : { 'result[result]' : res.toString(),
                     'result[timer_id]' : this.timer_id},
    });
  },
  //refreshResultList : function() {
  //  $('results').innerHTML = '';
  //  this.results.each(function(res) {
  //    $('results').insert({ bottom : this.listElement(res) });
  //  }.bind(this));
  //},
  listElement : function(result) {
    return $li({id: 'result_' + result.id, title: result.id},
      $span({'class' : 'time'}, parseTime(result.result, true)));
  },
  updateNames : function() {
    if (typeof this.nameUpdater != "undefined") return;
    console.log("starting updateNames");
    this.nameUpdater = new PeriodicalExecuter(
      this._updateNames.bind(this),
      3
    );
  },
  _updateNames : function() {
    if (this.updatingNames) return;
    this.updatingNames = true;
    console.log("updating names");
    var ids = this.results.select(function(e) {
      return e.id && !e.name;
    }).map(function(res) {
      return res.id;
    });

    if (!this.timer_id || !ids.any()) {
      console.log("nothing to update")
      this.updatingNames = false;
      return
    }

    // console.log("updating name for results " + ids);

    new Ajax.Request('/timers/' + this.timer_id + '/results.json', {
      onSuccess: this.onSuccess.bind(this),
      onFailure: function(resp) {
        console.log("FAIL", resp)
        this.updatingNames = false;
      },
      method : 'GET',
      parameters : { 'result_ids[]' : ids, 'with_names' : '1' }
    });
  },
  onSuccess : function(res) {
    console.log("response is ", res.responseJSON);
    console.log("in onSuccess, this is ", Object.inspect(this));
    res.responseJSON.each(function(result) {
      // console.log("adding name for " + result['result']);
      var name = result['name'];

      // console.log('name is ' + result['result']['name']);

      if (name) {
        var id = result['id'];

        // console.log("id to update is " + id);
        // console.log("this.results: " + this.results);
        var curr_result = this.results.find(function(r) {
          return parseInt(r.id) == parseInt(id);
        });

        // console.log('curr_result: ' + curr_result);

        curr_result['name'] = name;

        // console.log("now curr_result " + curr_result.id + " has name " + curr_result.name);
        var new_el = $('result_' + id);
        new_el.insert({bottom : " " + result['bib_number']})
        new_el.insert({bottom : " " + name})
        if (result["category_name"]) {
          new_el.insert({bottom : " " + result["category_name"]});
        }
        new_el.highlight();
      }
    }.bind(this));
    this.updatingNames = false;
  }
});
