function setUpGrid(data) {
    var createGridColumns = function (keys) {
        var columns = [];
        for (var i = 0; i < keys.length; i++) {
            columns.push({
                id: i,
                //name field is just for display
                name: keys[i],
                //"field" is the field used by the program a particular cell in row
                field: keys[i],
                width: 50,
                toolTip: keys[i],
                editor: Slick.Editors.Text
            });
        }
        return columns;
    };

    var headerClick = function (e, args) {
        var colInd = args.grid.getColumnIndex(args.column.id);
        args.grid.getSelectionModel().setSelectedRanges([new Slick.Range(0, colInd, grid.getData().length, colInd)]);
        //console.log(columnID);
    };
    var grid;
    //var data = []; //The data used by the cell grid
    //cell grid options for customization
    var options = {
        editable: true,
        enableAddRow: true,
        enableCellNavigation: true,
        asyncEditorLoading: false,
        autoEdit: false
    };

    var undoRedoBuffer = {
        commandQueue: [],
        commandCtr: 0,

        queueAndExecuteCommand: function (editCommand) {
            this.commandQueue[this.commandCtr] = editCommand;
            this.commandCtr++;
            editCommand.execute();
        },

        undo: function () {
            if (this.commandCtr == 0)
                return;

            this.commandCtr--;
            var command = this.commandQueue[this.commandCtr];

            if (command && Slick.GlobalEditorLock.cancelCurrentEdit()) {
                command.undo();
            }
        },
        redo: function () {
            if (this.commandCtr >= this.commandQueue.length)
                return;
            var command = this.commandQueue[this.commandCtr];
            this.commandCtr++;
            if (command && Slick.GlobalEditorLock.cancelCurrentEdit()) {
                command.execute();
            }
        }
    };
    // undo shortcut
    $(document).keydown(function (e) {
        if (e.which == 90 && (e.ctrlKey || e.metaKey)) { // CTRL + (shift) + Z
            if (e.shiftKey) {
                undoRedoBuffer.redo();
            } else {
                undoRedoBuffer.undo();
            }
        }
    });

    var pluginOptions = {
        clipboardCommandHandler: function (editCommand) {
            undoRedoBuffer.queueAndExecuteCommand.call(undoRedoBuffer, editCommand);
        },
        includeHeaderWhenCopying: false
    };
    //cell grid options for customization over
    var columns = createGridColumns(Object.keys(data[0]));
    //Building the grid and configuring the grid
    grid = new Slick.Grid("#myGrid", data, columns, options);
    grid.setSelectionModel(new Slick.CellSelectionModel());
    //enabling the excel style functionality by the plugin
    grid.registerPlugin(new Slick.CellExternalCopyManager(pluginOptions));
    grid.registerPlugin(new Slick.AutoTooltips());
    grid.onCellChanged;

    // Need to use a DataView for the filler plugin
    /*var dataView = new Slick.Data.DataView();
     dataView.onRowCountChanged.subscribe(function (e, args) {
     grid.updateRowCount();
     grid.render();
     });
     dataView.onRowsChanged.subscribe(function (e, args) {
     grid.invalidateRows(args.rows);
     grid.render();
     });
     dataView.beginUpdate();
     dataView.setItems(data);
     dataView.endUpdate();*/
    grid.registerPlugin(new Slick.AutoColumnSize());
    grid.onHeaderClick.subscribe(headerClick);
    return grid;
}