<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="testtable.aspx.cs" Inherits="Dynamic.testtable" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <link href="assets/css/bootstrap-table.min.css" rel="stylesheet" />

    <script src="assets/js/tableExport.min.js"></script>
    <script src="assets/js/jspdf.min.js"></script>
    <script src="assets/js/jspdf.plugin.autotable.js"></script>
    <script src="assets/js/xlsx.core.min.js"></script>

    <script src="assets/js/bootstrap-table.min.js"></script>
    <script src="assets/js/bootstrap-table-export.min.js"></script>
    <script src="assets/js/bootstrap-table-locale-all.min.js"></script>   
    
    <section class="main--content">    
        <div class="panel">
            <br />
            <div style="margin-right:10px; margin-left:10px">
                <table 
                    id="tbMain"
                    data-toggle="table" 
                    data-locale="mn-MN"
                    data-show-columns="true" 
                    data-minimum-count-columns="3" 
                    data-search="true"
                    data-search-align="left" 
                    data-pagination="true" 
                    data-pagination-pre-text="Өмнөх" 
                    data-pagination-next-text="Дараах"
                    data-show-pagination-switch="true"
                    data-show-toggle="true" 
                    data-show-fullscreen="true"
                    data-show-export="true"
                    data-export-types="['excel']"
                    data-export-data-type="all"
                    data-resizable="true"
                    data-export-options='{
                      "fileName": "testtables"
                    }'
                    >
                <thead>
                    <tr>
                        <th data-sortable="true" data-field="group">Бүлэг</th>
                        <th data-sortable="true" data-field="category">Ангилал</th>
                        <th data-sortable="true" data-field="bedcnt">Орны тоо</th>
                        <th data-sortable="true" data-field="no">Дугаар</th>
                        <th data-sortable="true" data-field="floor">Давхар</th>
                        <th data-sortable="true" data-field="intcom">Дотуур холбоо</th>
                        <th data-sortable="true" data-field="description">Тайлбар</th>
                        <th data-sortable="true" data-field="isminibar">Минибартай эсэх</th>
                        <th data-sortable="true" data-field="minibar">Минибарны загвар</th>
                        <th data-sortable="true" data-field="section">Жигүүр</th>
                        <th data-sortable="true" data-field="guestcnt">Зочны тоо</th>
                        <th data-sortable="true" data-field="action">Үйлдэл</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>aaaa</td>
                        <td>bbb</td>
                        <td>cc</td>
                        <td>dd</td>
                        <td>ee</td>
                        <td>ff</td>
                        <td>gg das asd asd a</td>
                        <td>11</td>
                        <td>22</td>
                        <td>33</td>
                        <td>44</td>
                        <td>b</td>
                    </tr>
                    <tr>
                        <td>йлыбрлёйорыб</td>
                        <td>sdfыбыөсөvsdf</td>
                        <td>12312бөысбө312</td>
                        <td>1ыб23</td>
                        <td>ыбөсыб</td>
                        <td>45ыбөсыбөс645645</td>
                        <td>ыбөсыбөс das asd asd a</td>
                        <td>ыбөсыбө</td>
                        <td>ыбөсыбөс</td>
                        <td>ыбөсыбөс</td>
                        <td>ыбөсыбөс</td>
                        <td>ыбөсыбөс</td>
                    </tr>
                    <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                    <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                    <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                    <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                    <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                    <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                    <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                    <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                    <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                    <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                    <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                    <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                    <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                    <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                    <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                    <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                    <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                    <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                    <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                    <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                         </tr>
                    <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                        <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                        <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                        <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                        <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                        <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                        <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                        <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                        <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                            </tr>
                                <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                            <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                            <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                            <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                            <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                            <tr>
                        <td>sdfvsdfv</td>
                        <td>sdfvsdf</td>
                        <td>12312312</td>
                        <td>123</td>
                        <td>234234</td>
                        <td>45645645</td>
                        <td>asdcas das asd asd a</td>
                        <td>asd</td>
                        <td>1233vwerv</td>
                        <td>dfsfsd</td>
                        <td>132123</td>
                        <td>b</td>
                    </tr>
                </tbody>
            </table>
            </div>
            <br />
        </div>
        
    </section>

</asp:Content>
