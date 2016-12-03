# Whitney
Whitney is a modular 3d printer system based on the Dollo design.

Whitney is currently a work in progress.

While the Dollo and Snappy printers have achieved a high level of printability, we believe that the next evolution for Reprap is in modularity. Just as in the 1700s each individual machine was hand-tuned for its individual parts, current 3d printer designs include specially designed parts just for the particular design. Customization is generally limited to choosing sizes. Using spare parts you already have often requires a large amount of design work, and designing a new mechanism (such as a rack and pinion drive) requires either grafting to an existing monolithic design or creating a whole new printer design.

# Modularity
A modular 3d printer system should allow the creation, testing, and refinement of individual mechanisms without having to make large changes to the rest of the printer (and allowing you to reuse parts easily). Different developers could then focus on different mechanisms.

Building a printed printer is a game of tradeoffs. Do you prefer printability or print quality? Do you have the money to spend or extra parts available for linear-rod movement, or are you working on a shoestring with no parts available? Allowing the builder to pick and choose which mechanisms go into a printer moves these tradeoffs from the printer designer to the printer builder.

# Structure of Whitney
Whitney is broken into <i>modules</i> and <i>variants</i>.

<i>Modules</i> are individual parts of a printer, such as a rack and pinion system, a structural system, or a particular type of Z-axis.

<i>Variants</i> are collections of specific <i>modules</i> which create a certain printer configuration. For instance, a machine could be built with a 100x100 build plate size, or a 200x200 size, etc. One variant could be designed for maximum printability, while another could be designed for maximum speed or quality using additional vitamins.

# Origins
Whitney draws on the work of Dollo by Ben Beezy, Spegelius and others. Some included models are from Revarbat's Snappy and NopHead's Mendel90.
