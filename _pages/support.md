---
layout: lab
title: "Support the lab"
permalink: /support/
description: "Help the SOS+CD Lab advance trustworthy science, open research tools, and the next generation of researchers."
---
<main id="main" class="interior-main wrap">
  <header class="page-heading"><h1>Help science<br>work better.</h1><p>Support the people and ideas behind more trustworthy, accessible, and effective research.</p></header>
  <section class="support-intro" aria-labelledby="support-mission">
    <div class="support-mission"><h2 id="support-mission">A better scientific record.<br>A stronger scientific community.</h2><p>At the Science of Science &amp; Computational Discovery Lab, we study how science works and build tools to improve it. We examine research integrity, develop computational methods for discovery, and investigate the systems that shape scientific opportunity.</p><p>Philanthropic support can help us pursue new questions, share useful research tools, and create opportunities for students to contribute.</p><a class="text-link" href="{{ '/publications/' | relative_url }}">Explore the work {% include lab-arrow.html %}</a></div>
    <aside class="support-action" aria-labelledby="give-heading">
      {% assign fund_url = site.data.giving.fund_url | default: '' | strip %}
      {% assign fund_name = site.data.giving.fund_name | default: '' | strip %}
      {% if fund_url != '' and fund_name != '' %}
      <h2 id="give-heading">Make a gift.</h2><p>Your gift through CU supports the {{ fund_name | escape }}.</p><a class="button button-primary" href="{{ fund_url | escape }}">Give to the lab {% include lab-arrow.html %}</a><p class="support-action-note">For monthly support, select the recurring-gift option on CU’s giving form.</p><a class="text-link" href="{{ site.data.giving.recurring_gifts_url }}">About recurring gifts {% include lab-arrow.html %}</a>
      {% else %}
      <h2 id="give-heading">Let’s make it possible.</h2><p>Interested in supporting SOS+CD? Contact Daniel Acuña to discuss your interests and arrange a gift through CU Boulder.</p><a class="button button-primary" href="mailto:{{ site.data.giving.contact_email }}?subject=Supporting%20the%20SOS%2BCD%20Lab">Discuss a gift {% include lab-arrow.html %}</a><p class="support-action-note">A dedicated online giving link for the lab is not yet available. CU Advancement can help confirm the designation for your gift.</p>
      {% endif %}
    </aside>
  </section>
  <section class="support-priorities" aria-labelledby="support-priorities-heading"><h2 id="support-priorities-heading">What your support could make possible.</h2>
    <article><h3>Research we can trust.</h3><p>Help us develop and study methods for identifying problems in scientific figures, publications, and AI-assisted research.</p><a class="text-link" href="{{ '/publications/?topic=integrity' | relative_url }}">Research integrity {% include lab-arrow.html %}</a></article>
    <article><h3>Tools that move ideas forward.</h3><p>Help us explore better ways to review research, discover relevant knowledge, and share methods with the scientific community.</p><a class="text-link" href="{{ '/publications/?topic=discovery' | relative_url }}">Peer review &amp; discovery {% include lab-arrow.html %}</a></article>
    <article><h3>People with questions worth pursuing.</h3><p>Help create opportunities for students and researchers to investigate how mentorship, collaboration, and funding shape science.</p><a class="text-link" href="{{ '/people/' | relative_url }}">Meet the lab {% include lab-arrow.html %}</a></article>
  </section>
  <div class="support-details">
    <section><h2>Give through CU.</h2><p>CU Boulder’s advancement team can help shape a gift around your interests and confirm how it will support the lab.</p><p><a href="mailto:{{ site.data.giving.advancement_email }}?subject=Gift%20to%20support%20the%20SOS%2BCD%20Lab">Contact Engineering Advancement</a></p><p><a href="{{ site.data.giving.advancement_url }}">Meet the college’s giving team</a></p><p>For matching gifts, checks, payroll deductions, and other giving options, see <a href="{{ site.data.giving.giving_faq_url }}">CU’s giving guidance</a>.</p></section>
    <section><h2>Organizations &amp; partners.</h2><p>Interested in a larger gift, a foundation-supported initiative, or a research partnership? Start a conversation with Daniel. CU can help identify the appropriate route for your goals.</p><a class="text-link" href="mailto:{{ site.data.giving.contact_email }}?subject=SOS%2BCD%20Lab%20partnership">Explore a partnership {% include lab-arrow.html %}</a></section>
  </div>
</main>
