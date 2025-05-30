# Neovim Config

This is my personal neovim config

## Dependencies

All dependencies can be found in the `requirements/` directory

I try to stay up to date with all developemnt platforms I use


| Platform | Note |
| --- | --- |
| Arch | Main platform |
| Windows | Dependencies through winget (script for easy installation in `scripts/`) |
| Ubuntu | Basically arch dependencies with renamed names |
| OpenSuse-Tumbleweed | Basically arch dependencies with renamed names |



### Arch

```bash
sudo pacman -S ${< ./requirements/arch.txt}
```


### Windows


```cmd
./scripts/winget.ps1

```

You might need to add C:\Program Files\Git\usr\bin\ to your PATH variable

> Startup time is horrible, idk why, might fix it in the future

### Other (OpenSuse-Tumbleweed/Ubuntu)

```bash
sudo %package manager% install ${< ./requirements/%distro%.txt}
```


