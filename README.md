# Homework Extension For Quarto

This extension provides some convenience filters for making course textbooks
as quarto books. Namely:
  - it creates a separate numbering scheme so that homework questions can be
  headed but numbered outside of the table of contents and section numbering. 
  - It creates a callout box that can contain a solution key that is suppressed
  with a single quarto parameter.

## Installing

```bash
quarto add gregmacfarlane/homework
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

Add the filter to the list of quarto filters,

```yaml
filters:
  - homework
```

Then, use the `.homework` attribute next to a heading at any level to
identify the heading as a homework problem with a title.

Additionally, the `.homework-key` div will create a callout with a solution.
The `show-solution` boolean flag gives you the option to print the callout 
or not [h/t to ginolhac](https://github.com/ginolhac/unilur).

```md
#### A homework problem {.homework}
```

## Example

This quarto document uses the homework filter on two separate homework equations,
along with their solutions.

```md
---
title: "Homework Example"
format: 
  html: 
    theme: cosmo
filters:
  - homework
show-solution: true
number-sections: true
---

## Heading
A section of text

### Subsection
Another section of text

## Homework {.unnumbered}
##### A basic problem {.homework}
Define *mobility*. 

::: {.homework-key}
Mobility is the ability people have to travel over distances afforded by
transportation systems. Often modes and facilities that can provide high
mobility --- expressways and high-speed rail, for example --- provide poor
*accessibility*, or the ability to reach destinations.
:::

##### A less basic problem {.homework}
A highway has a jam density of 120 vehicles per mile and a free flow speed of 75
miles per hour. What is the capacity of the highway assuming the Greenshields' 
traffic flow model?

::: {.homework-key}
In Greenshield's model, the maximum flow rate is 
$$ q_m = \frac{v_f k_j}{4}$$
So, for this question, the capacity is 
$$ \frac{120 \times 75}{4} = 2250$$
vehicles per hour. 
:::
```
![](https://i.imgur.com/8maEnMu.png)