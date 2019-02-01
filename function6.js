
    var parsed = (document.location.href.split('#')[1] || '').split('&');
    var params = parsed.reduce(function(params, param) {
      var param = param.split('=');
      params[param[0]] = decodeURIComponent(param.slice(1).join('='));
      return params;
    }, {});
  