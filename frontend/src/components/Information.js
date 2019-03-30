import React, { Component } from 'react';
import ReactTable from 'react-table';
import 'react-table/react-table.css';
import DatePicker from 'react-date-picker';
import InformationApi from '../api/Information';

export default class Information extends Component {
  constructor(props) {
    super(props);
    this.state = { data: [], startDate: new Date(), endDate: new Date(), loading: true };
    this.api = new InformationApi();
  }

  componentDidMount() {
    this.api.all().then(data => this.setState({ data: data, loading: false }));
  }

  formatDate(dateString) {
    return (new Date(dateString)).toLocaleDateString('en-US');
  }

  handleStartDateChange(date) {
    this.handleDateChange(date, 'startDate');
  }

  handleEndDateChange(date) {
    this.handleDateChange(date, 'endDate');
  }

  handleDateChange(date, field) {
    this.setState({ [field]: date });
  }

  async handleFilter() {
    if (!this.state.startDate || !this.state.endDate) return;

    await this.setState({ loading: true });

    const query = {
      start_date: this.state.startDate.toISOString().slice(0, 10),
      end_date: this.state.endDate.toISOString().slice(0, 10)
    };
    this.api.all(query).then(data => this.setState({ data: data, loading: false }));
  }

  renderColor(color) {
    const style = { background: color, 'borderColor': color };

    return (
      <div>
        <code>{color} </code>
        <div className='color-btn' style={style}></div>
      </div>
    );
  }

  renderTable() {
    const columns = [
      {
        Header: 'City',
        accessor: 'city',
      },
      {
        Header: 'Start Date',
        accessor: element => this.formatDate(element.start_date),
        id: 'start_date'
      },
      {
        Header: 'End Date',
        accessor: element => this.formatDate(element.end_date),
        id: 'end_date'
      },
      {
        Header: 'Price',
        accessor: 'price'
      },
      {
        Header: 'Status',
        accessor: 'status'
      },
      {
        Header: 'Color',
        accessor: 'color',
        id: 'colorDiv',
        Cell: row => this.renderColor(row.value)
      }
    ];

    return <ReactTable
             data={this.state.data}
             columns={columns}
             defaultPageSize={10}
             className='table'
             loading={this.state.loading}
           />;
  }

  render() {
    return (
      <div>
        <div className='date-range'>
          <DatePicker
            onChange={this.handleStartDateChange.bind(this)}
            value={this.state.startDate}
            locale='en-US'
            className='date'
          />
          <DatePicker
            onChange={this.handleEndDateChange.bind(this)}
            value={this.state.endDate}
            locale='en-US'
            className='date'
          />
          <button className='btn' onClick={this.handleFilter.bind(this)}>Filter</button>
        </div>
        <div className='table-responsive'>{this.renderTable()}</div>
      </div>
    );
  }
};
