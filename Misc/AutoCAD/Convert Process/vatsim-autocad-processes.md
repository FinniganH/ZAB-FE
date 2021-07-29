# AutoCad Processes for VATSIM Facility Engineers

## 1. Importing *.sct2 map data for AutoCad
#### 1.1. Use a browser console to run some JavaScript to perform the format conversion:
##### 1.1.1. Using Chrome as an example, press F12 to open the Developer tools, and enter the `Console` tab:
![image](https://user-images.githubusercontent.com/5103735/105210111-a1649b80-5b18-11eb-9ba6-ba9eae8df51b.png)
##### 1.1.2. Create a variable called `sct2` in the console, a multiline string enclosed by backticks, containing the entire contents of the map from the sector file:
![image](https://user-images.githubusercontent.com/5103735/105256493-d8a46e00-5b53-11eb-92a5-1a039b741e5b.png)
##### 1.1.3. Copy the code from [this Github Gist](https://gist.github.com/erikquinn/dfb3b9e8b16e1ba18d5c7357b8a726a7).
![image](https://user-images.githubusercontent.com/5103735/105256692-42247c80-5b54-11eb-9edd-f1b84310740c.png)
##### 1.1.4. Paste the copied code into the console, and hit enter. The code will perform the conversion to *.sct2 format and copy the resulting data to the clipboard.
##### 1.1.5. In AutoCad, select the layer where you want the lines to be drawn. Then click into the command bar (where it says _"Type a Command"_, and press `Ctrl+V` to paste. With larger maps, it may take _up to a few minutes_ to complete the drawing.

## 2. Importing mass text data into AutoCad (such as for adding fixes)
#### 2.1. Figure out how to format each input item in the shape of:
```
POINT [longitude],[latitude] -TEXT J L @ 0 [text]
```
###### For example, with the Dolphin VOR, do `POINT -80.349035555556,25.799961666667 -text J L @ 0 DHP`
#### 2.2 In AutoCad, select the layer where you want the lines to be drawn. Then click into the command bar (where it says _"Type a Command"_, and press `Ctrl+V` to paste. With larger sets of text, it may take _up to 15 minutes_ to complete the drawing.

---

## 3. Editing Maps in AutoCad
#### 3.1. Use `OSNAP` to change snapping options-- usually you should only snap to `EndPoint`.
#### 3.2. Use `LINE` to draw a new line.
#### 3.3. To apply dashing or styles to lines, open the layer menu with `LAYER`, and change that layer's `Linetype`.
#### 3.4. To add text, use the `TEXT` command. I recommend using the AutoCad font `cdm`, which is monospaced with zero-thickness characters with no curves, while still not being too ugly. Using other fonts may produce _outline-traced_ characters when exploding, resulting in skyrocketing line counts.
#### 3.5. To cut portions of a line which extend _beyond_ another line, use the `TRIM` command. Select all the relevant lines, run `TRIM`, then click the portions of the lines you want to remove.

---

## 4. Exploding text and styled lines to single lines
#### 4.1. Create a _new layer_ (I like to use `(SRC)` and `(OUT)` in my layer names to differentiate between source text/polylines/styledLines and the exploded lines to be exported).
#### 4.2. Select all items from the source layer, and run the `COPYTOLAYER` command, type `N` to specify by name, then choose the _output_ layer, and click OK, then `X` to exit.
#### 4.3. Hide the source layer and show the output layer.
#### 4.4. Use `APPLOAD` to load the AutoCad LISP `linexp.lsp`, available [here](https://drive.google.com/file/d/1yEJdwuFldXtBm4z4TmcU1QrVC0Y7Vvtu/view?usp=sharing). This only needs to be done once per AutoCad session, to make the `linexp` command available.
#### 4.6. I recommend using zoom level 1 or higher (`Z [space] 1`). Running `linexp` while zoomed further out could result in distortion/misalignment, especially with finer details (like small text).
#### 4.5. Select all items which need to be exploded (lines dashed by styling, polylines, text objects, etc), and run `linexp`.
#### 4.6. The `linexp` command will have moved all those lines to the "active" layer-- select the lines, change the color to `ByLayer`, move back to the appropriate output layer, and (with them still selected) run `EXPLODE` to separate any polylines still connected.



---

## 5. Exporting single lines from AutoCad
#### 5.1. Hide all layers other than those containing the data you wish to export.
#### 5.2. Run the `DATAEXTRACTION` command.
##### 5.2.1. If you have already created a *.dxe file, select `Edit an existing data extraction` to use the same settings. Skip the below and move to 5.3.
###### 5.2.2. If you have not already created a *.dxe file, the following will only have to be done once:
###### 5.2.3. Select `Create a new data extraction`, under "Data Source", choose `Select objects in the current drawing`, press the select button, then select the lines to export, and hit enter when done selecting. _Note that it doesn't matter what you selected before running the `DATAEXTRACTION` command, it is only here which determines what will be exported._
###### 5.2.4. On the next page, ensure the only `Object` type listed is `Line`. Any other types (including Text, MText, Polyline, etc) MUST be converted to simple Line objects before continuing with the export.
###### 5.2.5. On the next page, select _only_ `EndX`, `EndY`, `StartX`, and `StartY`.
###### 5.2.6. On the next page, right click the header column to hide `Count` and `Name` columns, and then drag the columns to the following order: `StartY, StartX, EndY, EndX`. You can also specify the output decimal precision through the "Set Column Data Format" menu.
##### 5.3. Specify the desired output location as a *.txt file, then press Next and Finish.

---

## 6. Reformatting exported single lines to *.sct2 format
###### Note: Given that the exported lines are in decimal format, they will need to be changed to DMS, as used in *.sct2. Though it is certainly possible to bypass conversion to *.sct2 in favor of moving directly to the decimal-based vSTARS/vERAM formats, the tooling provided for vSTARS/vERAM actually wants *.sct2 formatted data anyway, so converting AutoCad-exported data directly to vSTARS/vERAM would require a programmatic solution which I personally do not believe would be a good approach anyway.
#### 6.1. Use a browser console to run some JavaScript to perform the format conversion:
##### 6.1.1. Using Chrome as an example, press F12 to open the Developer tools, and enter the `Console` tab:
![image](https://user-images.githubusercontent.com/5103735/105210111-a1649b80-5b18-11eb-9ba6-ba9eae8df51b.png)
##### 6.1.2. Create a variable called `map` in the console, a multiline string enclosed by backticks, containing the entire contents of the exported *.txt file:
![image](https://user-images.githubusercontent.com/5103735/105212517-919a8680-5b1b-11eb-9e1f-b6e80618e8a6.png)
##### 6.1.3. Copy the code from [this Github Gist](https://gist.github.com/erikquinn/5b5fecdc9ba84ec92d467329939f1c9a).
![image](https://user-images.githubusercontent.com/5103735/105213132-52206a00-5b1c-11eb-8613-0b87bff82d09.png)
##### 6.1.4. Paste the copied code into the console, and hit enter. The code will perform the conversion to *.sct2 format and copy the resulting data to the clipboard.
##### 6.1.5. Return to the exported *.txt file, select all, and paste to overwrite the file with the *.sct2 data.
##### 6.1.6. Use a multiple-selection-capable editor (I recommend [Sublime Text](https://www.sublimetext.com/)) to select all lines of the pasted data and add a color (as defined in your sector file) to the end of each line.
###### 6.1.6.1. In Sublime Text, `Ctrl+A` to select all lines, `Ctrl+Shift+L` to select all lines _individually_, then `End` and start typing to specify the color. Note that with files of over ~10k lines, this can be slow. In these cases, Sublime Text will finish significantly faster than VSCode/Atom/Notepad++.

---

## 7. Using *.sct2 maps in vSTARs/vERAM files
#### 7.1. use normal processes to convert *.sct2 maps to vSTARS Video Map XML or vERAM GeoMap XML
##### 7.1.1 For vSTARS, use `SectorFileToVideoMap.exe`, from the vSTARS installation to convert, then import through the vSTARS Facility Management panel. See the [vSTARS FE Guide](https://vstars.metacraft.com/Documentation) for further details.
##### 7.1.2. For vERAM, use `GeoMap Set Editor.exe`, from the vERAM installation to convert, then adjust DCB Filter labels as desired, and save. Use `.reloadgeomaps` in vERAM to observe the changes without needing to restart. See the [vERAM FE Guide](https://veram.metacraft.com/Documentation) for further details.
