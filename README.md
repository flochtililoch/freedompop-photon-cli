# FreedomPop Photon CLI

This tools allows communication with the FreedomPop Photon.

## Features:
- Configuration of the device (based on a JSON file)
- Reset the device to factory settings
- Check device status
- Check device battery status
- Read attached hosts
- Monitor device configuration, send useful events

## Usage

```bash
$ bin/photon [action] [password] [host]
```

### Configuration

- Rename `config.json.example` to `config.json`

```bash
mv config.json.example config.json
```

- Adjust settings in `config.json`

```bash
$ bin/photon configure
```

### Reset the device to factory settings

```bash
$ bin/photon reset
```

### Check device status

```bash
$ bin/photon status
```

### Check device battery status

```bash
$ bin/photon battery
```

### Read attached hosts

```bash
$ bin/photon attached
```
