using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml.XPath;

namespace lw_6
{
    public partial class Form1 : Form
    {
        string connectionString;

        public Form1()
        {
            InitializeComponent();
            connectionString = ConfigurationManager.ConnectionStrings["lw_6.Properties.Settings.transport_logisticConnectionString"].ConnectionString;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            this.vehicleTableAdapter.Fill(this.transport_logisticDataSet.vehicle);
            this.driverTableAdapter.Fill(this.transport_logisticDataSet.driver);
            LoadVehicleAndDriverData();
        }

        private void LoadVehicleAndDriverData()
        {
            string query = @"SELECT d.first_name, d.last_name, v.mark, v.type, v.capacity
                            FROM driver d
                            INNER JOIN vehicle v
                            ON d.id = v.driver_id";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand command = new SqlCommand(query, conn);

                SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                dataAdapter.Fill(dataTable);

                BindingSource bindingSource = new BindingSource();
                bindingSource.DataSource = dataTable;

                dataGridViewDriverVehicle.DataSource = bindingSource;
                bindingNavigatorDriverVehicle.BindingSource = bindingSource;
            }
        }

        private void updateDriverTable(object sender, EventArgs e)
        {
            this.driverTableAdapter.Update(this.transport_logisticDataSet.driver);
            LoadVehicleAndDriverData();
        }

        private void updateVehicleTable(object sender, EventArgs e)
        {
            this.vehicleTableAdapter.Update(this.transport_logisticDataSet.vehicle);
            LoadVehicleAndDriverData();
        }

        private void LoadData(string query, DataGridView dataGridView)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlDataAdapter dataAdapter = new SqlDataAdapter(query, conn);
                    DataTable dataTable = new DataTable();
                    dataAdapter.Fill(dataTable);

                    dataGridView.DataSource = dataTable;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error: {ex.Message}");
            }
        }

        private void buttonSortDriver_Click(object sender, EventArgs e)
        {
            string sortField = comboBoxFieldDriver.SelectedItem?.ToString() ?? "id";
            string sortOrder = comboBoxSortDriver.SelectedItem?.ToString() ?? "ASC";
            string pageCount = comboBoxPageCountDriver.SelectedItem?.ToString();

            string query;
            if (string.IsNullOrEmpty(pageCount))
            {
                query = $"SELECT * FROM driver ORDER BY {sortField} {sortOrder}";
            }
            else
            {
                query = $"SELECT TOP {pageCount} * FROM driver ORDER BY {sortField} {sortOrder}";
            }

            LoadData(query, dataGridViewDriver);
        }

        private void buttonClearDriver_Click(object sender, EventArgs e)
        {
            this.driverTableAdapter.Fill(this.transport_logisticDataSet.driver);
            dataGridViewDriver.DataSource = this.transport_logisticDataSet.driver;

            comboBoxFieldDriver.ResetText();
            comboBoxSortDriver.ResetText();
            comboBoxPageCountDriver.ResetText();
        }

        private void buttonFilterByRangeVehicle_Click(object sender, EventArgs e)
        {
            string filterField = comboBoxFieldFilterByRangeVehicle.SelectedItem?.ToString();
            string from = textBoxFromFilterByRangeVehicle.Text;
            string to = textBoxToFilterByRangeVehicle.Text;

            if (string.IsNullOrEmpty(filterField))
            {
                MessageBox.Show("Please select a field for filtering.");
                return;
            }

            if (string.IsNullOrEmpty(from) || string.IsNullOrEmpty(to))
            {
                MessageBox.Show("Please enter both values for the range.");
                return;
            }

            string query = $"SELECT * FROM vehicle WHERE {filterField} BETWEEN {from} AND {to}";

            LoadData(query, dataGridViewVehicle);



            string query2 = $"SELECT * FROM driver d JOIN vehicle v ON d.id = v.driver_id WHERE d.first_name LIKE '%John%' AND {filterField} BETWEEN {from} AND {to}";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand command = new SqlCommand(query2, conn);

                SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                dataAdapter.Fill(dataTable);

                BindingSource bindingSource = new BindingSource();
                bindingSource.DataSource = dataTable;

                dataGridView2.DataSource = bindingSource;
            }
        }

        private void buttonClearVehicle_Click(object sender, EventArgs e)
        {
            this.vehicleTableAdapter.Fill(this.transport_logisticDataSet.vehicle);
            dataGridViewVehicle.DataSource = this.transport_logisticDataSet.vehicle;

            comboBoxFieldFilterByRangeVehicle.ResetText();
            textBoxFromFilterByRangeVehicle.ResetText();
            textBoxToFilterByRangeVehicle.ResetText();
        }

        private void buttonCalculateByFieldVehicle_Click(object sender, EventArgs e)
        {
            string field = comboBoxFieldCalculateVehicle.SelectedItem?.ToString();

            if (string.IsNullOrEmpty(field))
            {
                MessageBox.Show("Please select a field for calculate.");
                return;
            }

            string query = $@"SELECT 
                AVG({field}) AS AverageValue, 
                MAX({field}) AS MaxValue, 
                MIN({field}) AS MinValue
                FROM vehicle";
            // Password123
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand command = new SqlCommand(query, conn);
                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        string avg = reader["AverageValue"].ToString();
                        string max = reader["MaxValue"].ToString();
                        string min = reader["MinValue"].ToString();

                        dataGridViewVehicleCalculate.Rows.Add(avg, max, min);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error: {ex.Message}");
            }
        }

        private void buttonGroupByFieldVehicle_Click(object sender, EventArgs e)
        {
            string field = comboBoxFieldGroupByVehicle.SelectedItem?.ToString();

            if (string.IsNullOrEmpty(field))
            {
                MessageBox.Show("Please select a field for group.");
                return;
            }

            dataGridViewVehicleGroupBy.ClearSelection();

            string query = $"SELECT {field}, COUNT(*) AS count FROM vehicle GROUP BY {field}";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand command = new SqlCommand(query, conn);
                    SqlDataReader reader = command.ExecuteReader();

                    DataTable dataTable = new DataTable();
                    dataTable.Columns.Add("count", typeof(string));
                    dataTable.Columns.Add(field, typeof(string));

                    while (reader.Read())
                    {
                        string count = reader["count"].ToString();
                        string fieldValue = reader[field].ToString();

                        dataTable.Rows.Add(count, fieldValue);
                    }

                    dataGridViewVehicleGroupBy.DataSource = dataTable;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error: {ex.Message}");
            }
        }
    }
}
