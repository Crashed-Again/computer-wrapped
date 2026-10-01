# 🖥️ Computer Wrapped

**Spotify Wrapped, but for your computer.**

Computer Wrapped reads the app usage history Windows already keeps and turns it into a fun, Spotify-Wrapped-style summary of how you spend your time on your PC.

It shows things like:

* 🏆 Your most-used apps
* ⏱️ Total hours spent on your computer
* 📊 Your top 5 apps
* 🎮 Gaming, coding, browsing, media, and other categories
* 🤖 Your computer personality
* 🔥 Roasts based on how you use your PC
* 📸 A downloadable Instagram-story-sized summary image

## ✨ How it works

Computer Wrapped is a single `.bat` file containing both:

1. A Windows Batch script
2. An embedded PowerShell script

When you run it, the program:

1. Reads Windows **UserAssist** usage history.
2. Converts Windows' stored app identifiers into readable application names.
3. Calculates how much time you've spent using each application.
4. Generates a standalone HTML file.
5. Opens the result in your default browser.

Your generated file is saved to:

```text
Desktop\My Computer Wrapped.html
```

## 🪟 Requirements

### Operating system

**Windows 10 or Windows 11, 64-bit recommended.**

The program depends on Windows features that aren't available on macOS or Linux, particularly the Windows Registry's:

```text
HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist
```

### Windows versions

| Windows version | Support         |
| --------------- | --------------- |
| Windows 11      | ✅ Supported     |
| Windows 10      | ✅ Supported     |
| Windows 8.1     | ⚠️ Not tested   |
| Windows 7       | ⚠️ Not tested   |
| macOS           | ❌ Not supported |
| Linux           | ❌ Not supported |

**Recommended:** Windows 10 version 1809 or newer, or any current Windows 11 release.

## 📦 What you need

You don't need to install Python, Node.js, or any other programming language.

The project uses software already included with Windows:

* Windows Command Prompt
* Windows PowerShell
* Windows Registry
* A modern web browser

Chrome, Edge, Firefox, or another modern browser should work for viewing the generated Wrapped page.

## 🚀 How to use

1. Download `Computer Wrapped.bat`.
2. Double-click the file.
3. Wait while it reads your Windows usage history.
4. Your Computer Wrapped page will open automatically.
5. Have fun judging your screen time.

The generated HTML file can also be opened again later without running the `.bat` file.

## 🔐 Privacy

Computer Wrapped processes your usage history **locally on your computer**.

The script does not need an internet connection to calculate your usage statistics or generate the HTML report.

Your usage data is written to:

```text
Desktop\My Computer Wrapped.html
```

The generated page is a local HTML file.

### External resources

The generated page references the **Bricolage Grotesque** font from Google Fonts. If an internet connection is unavailable, the page falls back to system fonts.

## ⚠️ Limitations

Computer Wrapped relies on Windows **UserAssist** data, so the numbers aren't necessarily a perfect measurement of every second you've spent using an application.

For example:

* Windows may not track every type of application equally.
* Some applications may appear under unusual names.
* Usage history can be reset or cleared.
* Newly installed applications may have little or no history.
* The data represents what Windows has recorded, not necessarily your exact screen time.

The program also uses your Windows user profile's creation date when calculating the overall time period.

## 🛠️ Technical details

The `.bat` file contains an embedded PowerShell script.

The PowerShell portion reads:

```text
HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist
```

UserAssist stores application usage information in the Windows Registry. The script decodes the stored application identifiers, resolves known applications, calculates their usage time, and passes the results into the generated HTML page.

The UI itself is built with:

* HTML
* CSS
* JavaScript
* Canvas API

No external JavaScript framework is required.

## 📁 Output

After running the program, you'll get:

```text
Desktop/
└── My Computer Wrapped.html
```

The HTML page contains your generated Wrapped experience and can be opened in a browser like a normal webpage.

## 🎨 Features

### Wrapped-style presentation

Your statistics are presented as a series of full-screen slides with animated transitions.

### App recognition

The script recognizes many popular applications and games, including browsers, games, coding tools, communication apps, media apps, creative software, and more.

### Computer personality

Your usage is turned into a computer personality such as:

* **The Bug Farmer**
* **The Tab Hoarder**
* **The Notification Victim**
* **The "Just One Match" Liar**
* **The Desktop Couch Potato**
* **The Spreadsheet Goblin**
* **The Pixel Perfectionist**
* **The Prompt Whisperer**

### Shareable image

At the end of your Wrapped, you can generate a **1080 × 1920** image suitable for sharing as an Instagram Story.

## 📜 License

Add your preferred license here.
```
MIT License
```

## ⭐ Support

If you like the project, consider giving it a ⭐ on GitHub!

---

**Computer Wrapped — because apparently your computer has been keeping receipts.**
