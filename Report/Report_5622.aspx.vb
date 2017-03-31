Imports System.Data
Imports System.Web.UI
Imports Oracle.DataAccess.Client
Imports System.IO
Imports System.Exception
Imports System.Globalization

Partial Class Report_5622
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim dt As New DataTable
            dt = getBranch()
            ddlBranch.DataSource = dt
            ddlBranch.DataValueField = "BranchId"
            ddlBranch.DataTextField = "Name"
            ddlBranch.DataBind()

            GetYear()
        End If
    End Sub

    Protected Sub SubmitReport_Click(ByVal sender As Object, ByVal e As EventArgs) Handles SubmitReport.Click

        Dim BranchID As Integer
        BranchID = ddlBranch.SelectedValue
        Dim Year, Month As String
        Year = ddlYear.SelectedValue
        Month = ddlMonth.SelectedValue
        Response.Write(BranchID.ToString + "<br>" + Year + "<br>" + Month + "<br>")

        Dim para(2) As String
        para(0) = BranchID
        para(1) = Month
        para(2) = Year
        Dim spara As Integer = para.Length

        'Response.Write(spara & ":" & para(0) & ":" & para(1))
        CrytalBuild.CreateReport("5622.rpt", para, spara)

    End Sub

    Public Shared Function getBranch() As DataTable
        Dim dt As New DataTable
        Dim da As New OracleDataAdapter
        Dim con As New OracleConnection
        Dim cmd As New OracleCommand
        con = getConnection()
        cmd.Connection = con
        cmd.CommandType = CommandType.StoredProcedure
        cmd.CommandText = """SP_BRANCH"""
        cmd.Parameters.Add(New OracleParameter("cur", OracleDbType.RefCursor)).Direction = ParameterDirection.Output

        Try
            da.SelectCommand = cmd
            da.Fill(dt)
        Catch ex As Exception

        Finally
            con.Close()
        End Try

        Return dt
    End Function

    Public Shared Function getConnection() As OracleConnection
        Dim con As New OracleConnection(ConfigurationManager.ConnectionStrings("PawnShopData").ToString)
        con.Open()
        Return con
    End Function

    Sub GetYear()
        Dim startYear As Integer = DateTime.Today.Year
        Dim thaiYear As Integer = startYear + 543
        'Dim thaiYear As Integer = startYear
        Dim endYear As Integer = startYear - 15
        For yearIdx As Integer = startYear To endYear Step -1
            ddlYear.Items.Add(New ListItem(thaiYear, yearIdx))
            thaiYear = thaiYear - 1
        Next

        ddlYear.Items.Insert(0, "--กรุณาเลือกปี--")
    End Sub

End Class
