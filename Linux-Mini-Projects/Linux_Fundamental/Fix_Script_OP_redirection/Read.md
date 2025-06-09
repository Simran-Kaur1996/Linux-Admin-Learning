# 🔁 Linux Redirection, Logging, and Piping Demo

This script demonstrates the use of:

- Output and input redirection (`>`, `>>`, `<`)
- Standard streams (`stdout`, `stderr`)
- Piping (`|`)
- Logging with `tee` (to view and save output)

---

## 📁 Files Created

- `deployment.log` – Standard output log
- `deployment_errors.log` – Error log (stderr)
- `deployment_full.log` – Combined stdout and stderr with live display
- `shell_scripts.log` – Filtered `.sh` files using pipe and grep

---

## 🧪 Key Commands Used

| Feature        | Example                  |
| -------------- | ------------------------ | -------------------- |
| Overwrite      | `ls > file.txt`          |
| Append         | `echo Done >> file.txt`  |
| Input file     | `cat < input.txt`        |
| Error redirect | `ls /root 2> errors.txt` |
| Combined log   | `command 2>&1            | tee -a full_log.txt` |
| Pipe           | `ls                      | grep .sh`            |
| Tee            | `echo Hello              | tee output.txt`      |

---

## 🚀 How to Run

```bash
chmod +x linux_redirection_logging.sh
./linux_redirection_logging.sh
```
