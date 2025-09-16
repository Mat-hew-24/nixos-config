
io.write("Enter your username: ")
local username = io.read()

io.write("Enter your email: ")
local email = io.read()

local flake_folder = os.getenv("HOME") .. "/nixos-config"

local backup_cmd = string.format("cp %s/hardware-configuration.nix %s/hardware-configuration.nix.bak", flake_folder, flake_folder)
os.execute(backup_cmd)
print("Backup of flake's original hardware config created.")

local copy_cmd = string.format("cp /etc/nixos/hardware-configuration.nix %s/hardware-configuration.nix", flake_folder)
print("User's hardware config copied into flake folder.")

os.execute(string.format("sed -i 's/mat-hew-24/%s/g' %s/*.nix", username, flake_folder))
os.execute(string.format("sed -i 's/amonline2005@gmail.com/%s/g' %s/*.nix", email, flake_folder))
print("Username and email updated in flake .nix files.")

-- Step 7: Apply NixOS configuration via flake
print("Applying NixOS configuration from flake...")
os.execute(string.format("rm -f %s/.gitignore", flake_folder))
os.execute(string.format("git -C %s add .", flake_folder))
os.execute(string.format("sudo nixos-rebuild switch --flake %s", flake_folder))

print("Done! Your nixos-config flake is now updated with user's hardware config.")
