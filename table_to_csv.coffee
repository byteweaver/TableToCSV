class TableToCSV
    data: ""

    init: ->
        @add_button table for table in $('[data-table-to-csv]')

    add_button: (table) ->
        button = $('<button type="button" class="btn pull-right" id="missing-csv-download">CSV<i class="icon-download-alt"></i></button>')
        $(table).before(button)
        button.click (evt) => @parse table

    parse: (table) ->
        @data = ""
        @parse_row table.tHead.rows[0]
        @parse_row row for row in table.tBodies[0].rows
        blob = new Blob([@data], {type: "application/octet-stream;charset=utf-8"})
        saveAs(blob, table.getAttribute('data-table-to-csv'))

    parse_row: (row) ->
        cells = (cell.innerHTML for cell in row.cells)
        @data += cells.join(',') + "\n"

ttcsv = new TableToCSV
ttcsv.init()
