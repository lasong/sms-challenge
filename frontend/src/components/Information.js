import React, { Component } from 'react';
import ReactTable from 'react-table';
import 'react-table/react-table.css';
import InformationApi from '../api/Information';

export default class Information extends Component {
  constructor(props) {
    super(props);
    this.state = { data: [], start_date: '', end_date: '' };
    this.api = new InformationApi();
  }

  componentDidMount() {
    this.api.all().then(data => this.setState({ data: data }));
  }

  renderColor(color) {
    const style = { background: color, 'border-color': color };

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
        accessor: 'start_date'
      },
      {
        Header: 'End Date',
        accessor: 'end_date'
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
           />;
  }

  render() {
    return (
      <div className='table-responsive'>{this.renderTable()}</div>
    );
  }
};
