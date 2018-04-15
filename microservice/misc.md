. Refactoring inside a single code base is easy these days, while refactoring across service boundaries is hard. Scott table a few approaches to managing architecture change:

Don’t do it – live with the chaos of the distributed logic rather than the chaos of not knowing who’s responsible for maintaining the shared service.
One big version change – version all your services, test them together and release them together. However, Scott said *You should not have to version your services.* (Conflicting with Cameron Barrie’s advice in the Mobile at Warp Speed session: “You need the flexibility to change your APIs, and you can’t do that without versioning.”)
Build a temporary team (due to concern about conway’s law) to build the third service. Make sure you make the long-term ownership of the service clear after the temp team has disbanded. “Long-term ownership can’t be ambiguous.”


