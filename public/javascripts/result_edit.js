var ResultListUpdater = Behavior.create({
  initialize : function() {
    // console.log("this.element: " + this.element)
    this.timer_id = window.location.pathname.split("/")[2];
    this.results = [];
    this._updateList();
    this.listUpdater = new PeriodicalExecuter(this._updateList.bind(this), 3);
    this.updating = false;
  },
  _updateList : function() {
    if (this.updating) return;
    this.updating = true;
    new Ajax.Request(window.location.pathname + ".json", {
      method : 'GET',
      onSuccess : function(resp) {
        console.log("resp.status: ", resp.status);
        console.log("resp.statusText: ", resp.statusText);
        console.log("resp.responseHeaders: ", resp);

        var new_results = resp.responseJSON.map(function(res) {return res});

        // console.log("new results: " + new_results.size());

        this.results = this.results.concat(new_results);

        // console.log("this.results: " + this.results)

        new_results.each(function(result) {
          console.log("inserting result ", result.id)
          console.log("to ", this.element);
          var new_el = this._listElement(result);
          // console.log("new_el: " + new_el)
          this.element.insert({
            bottom: new_el
          });
          if (result.name) new_el.down('form').hide();
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
      parameters : this._ajaxParameters()
    });
  },
  _ajaxParameters : function() {
    console.log("in ajaxParameters, this.results is " + this.results)
    if (this.results.any()) {
      return { 'min_id' : this.results.map(function(res) { return res.id }).sort(function(a,b) {return a>b;}).last() }
    } else {
      return {}
    }
  },
  _listElement : function(result) {
    // console.log("in listELement, result is " + $H(result).inspect())
    var el = $li({id: 'result_' + result.id, title: result.id},
      $span({'class' : 'time'}, parseTime(result.result, true)),
      $form({
        action : window.location.pathname + "/" + result.id,
        id : "edit_result_" + result.id,
        'class' : "edit_result"
        }, " ",
        $input({'type' : 'text',
                id : "result_" + result.id + "_bib_number",
                value: result.bib_number ? result.bib_number.toString() : "",
                'size' : 3})
      ), " ",
      $span({'class' : 'bib_number'}, result.bib_number ? result.bib_number.toString() : ""), " ",
      $span({'class' : 'bib_number'}, result.name || ""), " ",
      $span({'class' : 'bib_number'}, result.category_name || "")
    );
    //// console.log("el is " + el);
    return el;
  }
});

ResultList = Class.create({
  initialize : function() {
    this.timer_id = window.location.pathname.split("/")[2];
    this.results = [];
  }
});

Event.addBehavior({
  '#results' : ResultListUpdater,
  '#results form:submit' : function(event) {
    var li = event.element().up('li').next('li');
    if (li) {
      li.down('input[type=text]').select();
    } else {
      this.down('input[type=text]').blur();
    }

    event.stop();
  },
  '#results input[type=text]:blur' : function(event) {
    if ($F(this).trim().empty()) return;
    event.stop();
    var el = event.element();
    var form_el = el.up('form');
    var li_el = el.up('li');

    //new Ajax.Updater(li_el.id, form_el.action, {
    //  method : 'PUT',
    //  parameters : { 'result[bib_number]' : $F(this) }
    //});

    new Ajax.Request(form_el.action + '.json', {
      method : 'PUT',
      onSuccess : function(resp) {
        li_el.insert({ before : listElement(resp.responseJSON) }).remove();
        $(li_el.id).highlight();
        Event.addBehavior.reload();
      },
      parameters : { 'result[bib_number]' : $F(this) }
    });
  },
  '#results:click' : Event.delegate({
    '.bib_number' : function(event) {
      event.element().hide();
      event.element().previous('form').
            show().down('input[type=text]').select();
    }
  })
});

var listElement = function(result) {
  // console.log("in listELement, result is " + $H(result).inspect())
  var el = $li({id: 'result_' + result.id, title: result.id},
    $span({'class' : 'time'}, parseTime(result.result, true)),
    $form({
      action : window.location.pathname + "/" + result.id,
      id : "edit_result_" + result.id,
      'class' : "edit_result"
      }, " ",
      $input({'type' : 'text',
              id : "result_" + result.id + "_bib_number",
              value: result.bib_number ? result.bib_number.toString() : "",
              'size' : 3})
    ).hide(), " ",
    $span({'class' : 'bib_number'}, result.bib_number ? result.bib_number.toString() : ""), " ",
    $span({'class' : 'bib_number'}, result.name || ""), " ",
    $span({'class' : 'bib_number'}, result.category_name || "")
  );
  //// console.log("el is " + el);
  return el;
}
