Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.IO.Compression.FileSystem

$form = New-Object System.Windows.Forms.Form
$form.Text = "自动发布工具"
$form.Size = New-Object System.Drawing.Size(520,360)
$form.StartPosition = "CenterScreen"

$title = New-Object System.Windows.Forms.Label
$title.Text = "自动发布工具 - 测试版"
$title.Font = New-Object System.Drawing.Font("Microsoft YaHei",16,[System.Drawing.FontStyle]::Bold)
$title.AutoSize = $true
$title.Location = New-Object System.Drawing.Point(30,25)
$form.Controls.Add($title)

$info = New-Object System.Windows.Forms.Label
$info.Text = "这个版本用于测试：下载、安装、打开、生成本地发布包。`n后续可以继续加卡密验证、云端发布、后台管理。"
$info.Font = New-Object System.Drawing.Font("Microsoft YaHei",10)
$info.Size = New-Object System.Drawing.Size(440,60)
$info.Location = New-Object System.Drawing.Point(30,70)
$form.Controls.Add($info)

$label = New-Object System.Windows.Forms.Label
$label.Text = "版本号："
$label.Location = New-Object System.Drawing.Point(30,150)
$label.AutoSize = $true
$form.Controls.Add($label)

$text = New-Object System.Windows.Forms.TextBox
$text.Text = "v1.0.0"
$text.Location = New-Object System.Drawing.Point(90,146)
$text.Width = 180
$form.Controls.Add($text)

$button = New-Object System.Windows.Forms.Button
$button.Text = "生成本地发布包"
$button.Location = New-Object System.Drawing.Point(30,200)
$button.Size = New-Object System.Drawing.Size(180,40)
$form.Controls.Add($button)

$status = New-Object System.Windows.Forms.Label
$status.Text = "状态：等待操作"
$status.Location = New-Object System.Drawing.Point(30,260)
$status.Size = New-Object System.Drawing.Size(440,40)
$form.Controls.Add($status)

$button.Add_Click({
    try {
        $version = $text.Text.Trim()
        if (-not $version) { $version = "v1.0.0" }

        $desktop = [Environment]::GetFolderPath("Desktop")
        $folder = Join-Path $desktop ("AutoReleaseOutput-" + $version)
        $zip = $folder + ".zip"

        if (Test-Path $folder) { Remove-Item $folder -Recurse -Force }
        if (Test-Path $zip) { Remove-Item $zip -Force }

        New-Item -ItemType Directory -Path $folder | Out-Null
        "自动发布测试包" | Out-File (Join-Path $folder "release.txt") -Encoding UTF8
        "版本：$version" | Out-File (Join-Path $folder "version.txt") -Encoding UTF8
        "生成时间：$(Get-Date)" | Out-File (Join-Path $folder "time.txt") -Encoding UTF8

        [System.IO.Compression.ZipFile]::CreateFromDirectory($folder, $zip)

        $status.Text = "状态：已生成 " + $zip
        [System.Windows.Forms.MessageBox]::Show("发布包已生成到桌面：`n$zip","完成")
    } catch {
        [System.Windows.Forms.MessageBox]::Show($_.Exception.Message,"错误")
    }
})

[void]$form.ShowDialog()