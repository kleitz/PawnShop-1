Imports Newtonsoft.Json
Imports PSCS.Libary.Models
Imports System.Data
Imports WebUtilFn
Imports System.Reflection
Partial Class Store_02Out_ajax_loadQueue
    Inherits System.Web.UI.Page

    Private Sub Store_02Out_ajax_loadQueue_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim tokenOb As New PSCS.Libary.Models.TokenClass
        If Not PawnUtilFn.GetSessionUserObj(tokenOb) Then
            'Response.Redirect("../../login.aspx")
            Exit Sub
        End If

        Try
            BindInventoryQueue()
        Catch ex As Exception
            Response.Write("Error!!!")
        End Try
    End Sub

    Sub BindInventoryQueue()
        'Loop

        Dim tokenOb As New PSCS.Libary.Models.TokenClass

        If Not PawnUtilFn.GetSessionUserObj(tokenOb) Then
            Exit Sub

        End If
        Dim Branch As Integer = tokenOb.BranchId

        Dim InventoryQueue As New List(Of PSCS.Libary.Models.InventoryQueueClass)
        Dim BranchID As Integer = Branch 'Request.Form("ticketID")
        Dim skip As Integer = 0 'Request.Form("ticketID")
        Dim take As Integer = 0 'Request.Form("ticketID")


        If PawnServicesFn.GetInventoryQueue(CType(Session(WebConstant.SessionName_UserObj), TokenClass).TokenId, BranchID, skip, take, InventoryQueue) Then
            'GridView1.DataSource = InventoryQueue
            'GridView1.DataBind()
            'lblCnt.Text = GridView1.Rows.Count().ToString()

            'Dim dt As New DataTable
            'dt = ConvertToDataTable(Of DataTable)(InventoryQueue)
            Dim json = JsonConvert.SerializeObject(InventoryQueue, Formatting.Indented)
            Response.Write(json)

        End If
    End Sub
    Protected Function GetQueueStatusStr(qs As Object) As String
        If qs Is Nothing OrElse Convert.ToString(qs) = "" Then
            Return ""
        Else
            Dim qsi As Integer = CInt(qs)
            Select Case qsi
                Case 1
                    Return "รอทำรายการ"
                Case -1
                    Return "ยกเลิก"
                Case 2
                    Return "พร้อมทำรายการ"
                Case 0
                    Return "รอ"
                Case Else
                    Return ""
            End Select
        End If
    End Function

    Protected Function GetQueueCreateTime(qd As Object) As String
        If qd Is Nothing OrElse Convert.ToString(qd) = "" Then
            Return ""
        Else
            Dim dt As DateTime = Convert.ToDateTime(qd)
            If dt.Date = Now.Date Then
                Return dt.ToString("HH:mm")
            Else
                Return DateTime.Compare(Now.Date, dt.Date) & " วันก่อน"
            End If
        End If
    End Function
    Public Shared Function ConvertToDataTable(Of T)(ByVal list As IList(Of T)) As DataTable
        Dim table As New DataTable()
        Dim fields() As FieldInfo = GetType(T).GetFields()
        For Each field As FieldInfo In fields
            table.Columns.Add(field.Name, field.FieldType)
        Next
        For Each item As T In list
            Dim row As DataRow = table.NewRow()
            For Each field As FieldInfo In fields
                row(field.Name) = field.GetValue(item)
            Next
            table.Rows.Add(row)
        Next
        Return table
    End Function
End Class
