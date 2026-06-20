![WeisAir Logo](docs\weisair_logo\iterations\v1.png)

# Repository Description
This repository contains all the individual customizations of my X-Plane 12 home flight simulator setup that I call <b> WeisAir Appliance </b>. It comprises configuration files, scripts for all used HID devices but also documentation and imagery such as icons, logos and artwork.

# The Story
## Purpose and Motivation

As a flight sim enthusiast, I love exploring virtual skies. As an engineer I love anything that is connected with building stuff in both hardware and software. This combination is a lot of fun, although my engineering heart is sometimes even stronger so I often catch myself programming and configuring way more than actually flying :D

After fiddling around this hobby for a couple of years I decided to bring things to digital paper finally for couple of reasons

- My primary reason is to have a central place that allows me to store all relevant assets that I created to customize my X-Plane 12 Setup - due to my daily job in IT a VCS like Github is the straight way forward to achieve this

- I wanna share some of my experience I gathered along the way to give newbies but also experienced simmers valuable starting points and learning nuggets, especially if they have similar conditions and [Requirements and Constraints](#requirements) to the ones I have

## Requirements and Constraints

- <b>Multiple Aircraft Support</b>: Although I have started my flight simulation journey on the Boeing 737-800 NG, which I still fly a lot, a lot of other Aircrafts are in my field of interest and should be supported by my setup. Currently the following ones are included

  <b>Airliner</b>
    - Boeing 737-800 NG (ZIBO Mod)
    - Boeing 747-8i (SSG)
    - Boeing 737-300 (IXEG)
    - Embrear E170 (X-Crafts)
    - Saab 340A (LES)
    - Airbus A330 (X-Plane 12 Default Aircraft)
    - DC-3 (LES)

  <b>General Aviation</b>
    - Cessna 172NG (Airfoillabs C172NG)
    - SR-22 (X-Plane 12 Default Aircraft)
    - Lancair Evolution (X-Plane 12 Default Aircraft)
    - Cirrus Jet (X-Plane 12 Default Aircraft)
  
- <b>Compact Design</b>: I do not have much space at home for my hobby. I cannot build huge rigs with overhead panels, pedestral, etc. I want to create and integrate devices that I can easily take aside when they are not needed.

- <b>Little-to-Zero In-Flight mouse operations</b>: I try to minimize the usge of my mouse within the virtual cockpit. 

  TL;DR: 
  - Aircraft not moving -> Mouse input is welcome!
  - Aircraft in movement -> Mouse input is to be avoided.

  Explaination:

  Due to my "compact design" reqirement I cannot build all physical panels with switches and buttons to accomplish that. I rather chose a solution that allows me to reduce mouse usage to only ground operations. On the ground (during flight planning, aircraft startup) it is totally fine for me use the mouse for e.g. configuring the overhead panel. because here, I have time and the effort to replicate the virtual buttons to hardware buttons is insane and impossible in my case (see "multiple aircraft support" requirements). However, during flight, I want to have all essential functions (auto pilot control, radio control, instrument visualizations,...) easily accessible.

- <b>Haptic Inputs</b>: I really like to prefer physical buttons, switches, rotary knobs and levers over touch-screen solutions. Thus I want to use as many "physical" input devices as possible in my given limited space.

- <b>Aged Hardware</b>: My hardware setup is already pretty old, so I have to live with that constraint so far, trying to get most out of it by [Balancing the performance settings](#performance). My systems key specs are:

  - CPU:	Intel(R) Core(TM) i5-8600K CPU @ 5.2 GHz (delidded, overclocked, AIO water-cooled)
  - GPU: Geforce GTX 1080Ti, 11GB VRAM
  - RAM:	32,0 GB

- <b>Automation</b>: I try to automate my flight sim environment as much as I can, e.g. run scripts that are automatically opening and positioning tools I need (maps, panels)

# The Setup

## Architecture

My setup consists of the following modules

- Primary System: Simulator Host
- Secondary System: Auxilliary System

The main idea is to have one dedicated machine running X-Plane 12 with only essential additional software. Everything else that can be offloaded (e.g. Air Manager Panels, Navigraph) will run on the secondary machine. The reason for that is performance (see [Performance](#performance) for details). Due to my aged hardware, I need to take as much load from the simulator system as possible. I ran X-Plane 12 for several years "all-in-one" on a single machine. During performance measurements I noticed that especially stutters but also lower frame times were the positive impact of not having all in one. 

The following passage shows what is running on which machine in detail and how both machines are connected with each other:

|| Primary System | Secondary System|
|-|----------------|-----------------|
|Specs| <ul><li>PC<li>i5-8600K CPU @ 5.2 GHz<li>32GB RAM<li>GTX 1080Ti 11GB<li>Windows 11 Pro</ul> | <ul><li>Lenovo Yoga 12 Convertible<li>i7-5500U CPU @ 2.4 GHz<li>8GB RAM<li>Intel HD 5500<li>Windows 11 Pro |
|Software|<ul><li>X-Plane 12<li>X-Organizer<li>X-Toolbox<li>XP Map Enhancement</ul>|<ul><li>Air Manager<li>Navigraph Charts<li>StreamDeck Software</ul>|
|Connected Devices|<ul><li>Honeycomb Yoke<li>Saitek Throttle Quadrant 1<li>Saitek Throttle Quadrant 2<li>Saitek Rudder Pedals<li>WeisAir Switch Panel<li>Knobster<li>TCA Airbus Flight Stick</ul>|<ul><li>Ext. Touch Screen<li>StreamDeck XL</ul>|
|Network| Connected via GBit LAN to home network | Connected via 1GBit LAN to home network |

## Processes

The following Sequence Diagram shows how my simulator environment is started from scratch:

<ol>
  <li> Turn on primary system
  <li> Turn on secondary system
  <li> Once Windows has ideled on both system either hit "LEARN" for offline or "FLY" for online flying

![WeisAir StreamDeck Start Screen](docs\readme_resources\sd_start.png)
  </ol>

<ol start=4>
  <li> Wait for the secondary system to automatically complete the following steps
      <ul>
        <li> Start Air Manager
        <li> Mimimize Air Manager
        <li> Start EFB Environment
          <ul>
            <li> Start EFB Command Bar (Virtual Streamdeck)
            <li> Start Navigraph Charts as Kiosk-Mode Web page through an AutoHotKey Script
            <li> Start Simbrief as Kiosk-Mode Web page through an AutoHotKey Script for initial Flight Planning
          </ul>
        <li> start X-Plane 12 remotely on primary system through StreamDeck / Bitfocus Companion. The remote call starts either the X-Organizer-configured online or offline configuration of X-Plane 12
      </ul>
  <li> plan and file flight Plan n Simbrief. Afterwards the filed plan will automatically be loaded by "Simbrief downloader"
  <li> Configure desiered flight in X-Plane 12 UI
  <li> the secondary system will automatically load the proper Air Manger Panel and the proper StreamDeck Profile
  <li> load simbrief flight in Navigraph Charts on secondary system
  <li> proceed with checklist process once you are in the virtual cockpit
</ol>


## Configuration

This chapter lists the required congiguration for individual hardware and software components.

### Windows 11 Settings
#### System Parameters
  - Windows Engergy Mode to "hightest performance"
  - disable unused services and minimize started services
  - **Todo**: add current configuration

#### Firewall Rules

  - Allow TCP/UDP connections to X-Plane 12 within Windows Firewall (ingress / egress)
  - Allow webfmc-win.exe (located in %XPLANEDIR%/Resources/Plugins/webfmc/bin) within private network
  - **ToDo** Add Screenshots

#### Junctions

I decided to create file system junctions to hard disk directories that I use in multiple usage scenarios. That allowes me to:

- have multiple installations of X-Plane 12 running in parallel (e.g. stable version / latest beta version) without having large files doubled such as
  - Scenery
  - Aircrafts
  - Screenshots / Recordings

- Have all my custom configuration in one place (i.e. this repo) to maintain the code centrally and just link it to the X-Plane Configuration, e.g.
  - Lua Scripts
  - AirManager Instruments / Panel
  - Custom StreamDeck Graphics

The following table shows the most relevant junctions and their purpose:.

**ToDo**: Add table

### X-Plane 12 Settings
#### Graphics
#### Aircraft Settings
##### Zibo 737

- throttle noise
- Landing lights static (not pulsing)

#### Other

### Bitfocus Companion
### Simbrief Downloader

- active options
  - Run this programm automatically at startup
  - Minimize to tray
  - Show notification when minimizing to tray
  - always overwrite existing files when exporting
  - always export new flights automatically
  
### Streamdeck / apilotsdeck

### Firefox

I use Firefox as my browser to access Simbrief / Navigraph Charts on my WeisAir EFB. For that I need to run the urls in "Kiosk" mode but with a specific window size to max out the space on the small display. For that, Firefox needs to have the following config:

- go to about:config
- set full-screen-api.ignore-widgets = true


## Performance

Elaborate on key impacts on Performance

## State of the Art

This section adds screenshots of the current state of both my custom Air Mangager Panels as well as StreamDeck Profiles.

### Air Manager Panels

### StreamDeck Profiles

# The Future
## Next Steps

- consider different buttons for Online/Offline flight (especially ATC dialog)
  - either use X-Organizer "Preferences Module"
  - or create a custom command that somehow detects whether xPilot Plugin is loaded (aka "I want to fly online")
- stabilize HDI device recognition
  - rename second "Throttle Quadrant"?
  - write batch script that gets a list of needed USB hardware and runs XP12 only if all of them are connected. If not - give a message window to continue at own risk,
- ergonomics - use fixed chair instead of rollable chair
- mount TCA flight stick

## Linux

The only reason at the moment to not run everything on Linux is the extensive usage of StreamDeck and especially the apilotsdeck streamdeck plugin which only runs in Windwows / Mac. Once there is either a linux-compatible version of it or I have had enogh time to develop my own Linux-capable plugin, I will probably switch to Linux. 

## Known Issues

- Linux Airmanager unstable

# The Key Learnings

- Offloading 3rd Party Software to secondary machine is key to good / stable / stutter-free performance (at least on old machines like my one)

- For IFR flights, the default XP12 scenery is more than enough. For VFR flight choose XP Map Enhancement for an easy-to-setup ortho solution

- Do not improve your setup too much based on theoretical ideas or other ones opinions. Instead: FLY in your setup -> note down issues and fight them specifically