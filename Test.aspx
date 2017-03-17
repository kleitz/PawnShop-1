<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Test.aspx.vb" Inherits="Test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
    <script src="js/jquery.js"></script>
    <script src="Scripts/jquery.validate.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#form1').validate({
                rules: {
                    name: {
                        require :true
                    },
                    surname: {
                        require :true 
                    }
                }
            });
        });

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td>
                    Name
                </td>
                <td>
                    <input name="name" type="text" />
                </td>
            </tr>
            <tr>
                <td>
                    Surname
                </td>
                <td>
                    <input name="surname" type="text" />
                    <input name="submit" type="submit" value="submit" />
                </td>
            </tr>
        </table>


    </div>
    </form>
</body>
</html>
