Imports WebUtilFn

Partial Class Test
    Inherits System.Web.UI.Page

    Private Sub Test_LoadComplete(sender As Object, e As EventArgs) Handles Me.LoadComplete
        Dim dstr As String = "29/02/2559"
        Dim d As DateTime = Convert.ToDateTime(dstr, getDatetimeFormat)

        Response.Write(d)
    End Sub
End Class
