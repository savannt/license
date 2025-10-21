# machine_id.nim
import std/[osproc, strutils, strformat, md5]

when defined(linux):
  proc getMachineId*(): string =
    ## Generate stable machine identifier from multiple sources
    var components: seq[string]
    
    # Machine ID (systemd)
    try:
      let machineId = execProcess("cat /etc/machine-id 2>/dev/null")
      if machineId.len > 0:
        components.add(machineId.strip())
    except:
      discard
    
    # Combine and hash
    if components.len == 0:
      raise newException(IOError, "Could not generate machine ID")
    
    let combined = components.join("|")
    result = $toMD5(combined)

when defined(windows):
  proc getMachineId*(): string =
    var components: seq[string]
    
    # Windows Machine GUID
    try:
      let guid = execProcess("reg query HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Cryptography /v MachineGuid")
      if "MachineGuid" in guid:
        components.add(guid.strip())
    except:
      discard
    
    if components.len == 0:
      raise newException(IOError, "Could not generate machine ID")
    
    let combined = components.join("|")
    result = $toMD5(combined)

when defined(macosx):
  proc getMachineId*(): string =
    var components: seq[string]
    
    # Hardware UUID
    try:
      let uuid = execProcess("ioreg -rd1 -c IOPlatformExpertDevice | grep IOPlatformUUID")
      if uuid.len > 0:
        components.add(uuid.strip())
    except:
      discard
    
    # Serial number
    try:
      let serial = execProcess("ioreg -l | grep IOPlatformSerialNumber")
      if serial.len > 0:
        components.add(serial.strip())
    except:
      discard
    
    if components.len == 0:
      raise newException(IOError, "Could not generate machine ID")
    
    let combined = components.join("|")
    result = $toMD5(combined)


when isMainModule:
  echo "✓ Machine-ID generated!"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo getMachineId()
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "Use this ID to generate a license."
  echo " → https://thingking.org/create ←"