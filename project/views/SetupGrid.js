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
    grid.registerPlugin(new Slick.AutoTooltips());
    grid.onCellChanged;
    //enabling the excel style functionality by the plugin
    grid.registerPlugin(new Slick.CellExternalCopyManager(pluginOptions));
    // Need to use a DataView for the filler plugin
    var dataView = new Slick.Data.DataView();
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
    dataView.endUpdate();
    var overlayPlugin = new Ext.Plugins.Overlays({});
    // Event fires when a range is selected
    overlayPlugin.onFillUpDown.subscribe(function (e, args) {
        var column = grid.getColumns()[args.range.fromCell];
        // Ensure the column is editable
        if (!column.editor) {
            return;
        }
        // Find the initial value
        var value = dataView.getItem(args.range.fromRow)[column.field];
        dataView.beginUpdate();
        // Copy the value down
        for (var i = args.range.fromRow + 1; i <= args.range.toRow; i++) {
            dataView.getItem(i)[column.field] = value;
            grid.invalidateRow(i);
        }
        dataView.endUpdate();
        grid.render();
    });
    grid.registerPlugin(overlayPlugin);
    grid.registerPlugin( new Slick.AutoColumnSize());
    grid.onHeaderClick.subscribe(headerClick);
    return grid;
}