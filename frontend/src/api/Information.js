const request = require('superagent');

export default class Information {
  constructor() {
    this.ajax = request;
    this.host = 'http://localhost:8080/api';
  }

  all(queryParams) {
    return this.ajax.get(`${this.host}/information`).set('Accept', 'application/json')
      .query(queryParams || {}).then(response => response.body);
  }
}
