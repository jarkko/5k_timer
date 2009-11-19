var Timer = Class.create({
  initialize : function(element, id) {
    this.element = $(element);
    this.results = [];
    if (typeof id != "undefined") this.timer_id = id;
  },
  updateTime : function() {
    var cur = new Date().getTime();
    this.element.innerHTML = '';
    this.element.update(this.parseTime(this.getTimeDiff(cur)));
  },
  parseTime : function(time_diff, parts) {
    var hrs = parseInt(time_diff / (1000 * 60 * 60)),
        left = time_diff % (1000 * 60 * 60);

    var mins = parseInt(left / (1000 * 60)),
        left = left % (1000 * 60);

    var secs = parseInt(left / 1000);
    var res = [hrs, mins, secs].map(this.pad).join(":");
    
    if (typeof parts != "undefined") {
      var parts = left % 1000
      res = res + "." + this.pad(parseInt(parts / 10));
    }
    
    return res;
  },
  pad : function(str) {
    if (str.toString) str = str.toString();
    if (str.length < 2) {          
      (2 - str.length).times(function() {
        str = "0" + str;
      });
    }
    return str;
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
          var id = res.responseJSON['timer']['id'];
          this.timer_id = id;
        }.bind(this),
        method : 'POST', 
        parameters : { 'timer[start_time]' : this.start_time }, 
      });
      
      this.reseted = false;
    }
    this.pe = new PeriodicalExecuter(this.updateTime.bind(this), 0.25);
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
    var result = {'res': res}
    this.results.push(result);
    //this.refreshResultList();
    var el = this.listElement(res);
    $('results').insert({ bottom : el.highlight() });
              
    new Ajax.Request('/results.json', {
      onSuccess: function(res) {
        var id = res.responseJSON['result']['id'];
        el.writeAttribute('id', 'result_' + id);
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
  listElement : function(str) {
    return new Element('li').update(this.parseTime(str, true));
  },
  updateNames : function() {
    console.log("starting updateNames");
    this.nameUpdater = new PeriodicalExecuter(
      this._updateNames.bind(this),
      5
    );
  },
  _updateNames : function() {
    console.log("updating names");
    var ids = this.results.select(function(e) {
      return e.id && !e.name;
    }).map(function(res) {
      return res.id;
    });
        
    if (!this.timer_id || !ids.any()) return;
  
    console.log("updating name for results " + ids);
  
    new Ajax.Request('/timers/' + this.timer_id + '/results.json', {
      onSuccess: this.onSuccess.bind(this),
      method : 'GET',
      parameters : { 'result_ids[]' : ids }
    });
  },
  onSuccess : function(res) {
    console.log("response is " + res.responseJSON);
    console.log("in onSuccess, this is " + Object.inspect(this));
    res.responseJSON.each(function(result) {
      console.log("adding name for " + result['result']);
      var name = result['result']['name'];
      
      console.log('name is ' + result['result']['name']);
      
      if (name) {
        var id = result['result']['id'];
        
        console.log("id to update is " + id);
        console.log("this.results: " + this.results);
        var curr_result = this.results.find(function(r) {
          return parseInt(r.id) == parseInt(id);
        });
        
        console.log('curr_result: ' + curr_result);
        
        curr_result['name'] = name;
        
        console.log("now curr_result " + curr_result.id + " has name " + curr_result.name);
        
        $('result_' + id).insert({bottom : " " + name}).highlight();
      }
    }.bind(this));
  }
});