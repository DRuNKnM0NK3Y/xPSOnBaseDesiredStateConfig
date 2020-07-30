---
## **Introduction**
This provides a mechanism for converting DSC configurations to composite resources.

---
## **Requirements**
This module requires the following DSC resources
- **microsoft/CompositeResource**

---
## **Usage**
As noted on the [CompositeResource](https://github.com/Microsoft/CompositeResource) site on GitHub, the tool converts a *configuration* into a composite resource.

Thus, instead of listing out multiple configurations in a LCM config file (e.g. IisServer, AppServer, WebServer), you build one configuration with all the desired features, convert it to a composite resource, then just call the one config from the LCM.

