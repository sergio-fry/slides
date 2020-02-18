---
paginate: true
theme: gaia
---
<style>
  section {
    background: white;
  }
  td {
    background: white !important;
    border: 0px !important;
  }
  .folders {
    font-size: 18px;
  }
</style>

<!--
_paginate: false
_class: lead
-->

# Modular Rails Application

Sergei O. Udalov

---

# Apps

<pre class='folders'>
apps/<b>api</b>
apps/<b>auth</b>
apps/<b>blog</b>
config
db
lib
</pre>


---

# App is a micro Rails

<table width="100%"><tr><td width="50%">

App::Auth

<pre class='folders'>
apps/<b>auth</b>/
         assets
         controllers
         db
         models
         views
</pre>

</td><td>

App::Blog

<pre class='folders'>
apps/<b>blog</b>/
         assets
         controllers
         db
         models
         views
</pre>

</td></tr></table>


---

# Main app

<pre class='folders'>
apps/api
apps/auth
apps/blog
apps/<b>main</b>
</pre>
