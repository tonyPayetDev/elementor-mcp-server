/* =============================================
   Elementor MCP Server — main.js
   ============================================= */

// ── Tab switcher ──────────────────────────────
document.querySelectorAll('.tab-btn').forEach(btn => {
  btn.addEventListener('click', () => {
    const group = btn.closest('.install-block');
    group.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
    group.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'));
    btn.classList.add('active');
    const target = group.querySelector(`#${btn.dataset.tab}`);
    if (target) target.classList.add('active');
  });
});

// ── Copy button ───────────────────────────────
document.querySelectorAll('.copy-btn').forEach(btn => {
  btn.addEventListener('click', () => {
    const block = btn.closest('.code-block');
    const pre   = block.querySelector('pre');
    const text  = pre ? pre.innerText : '';
    navigator.clipboard.writeText(text).then(() => {
      btn.classList.add('copied');
      const span = btn.querySelector('span');
      if (span) { span.textContent = 'Copied!'; }
      setTimeout(() => {
        btn.classList.remove('copied');
        if (span) { span.textContent = 'Copy'; }
      }, 2000);
    });
  });
});

// ── Scroll fade-in ─────────────────────────────
const observer = new IntersectionObserver(entries => {
  entries.forEach(e => {
    if (e.isIntersecting) {
      e.target.classList.add('visible');
      observer.unobserve(e.target);
    }
  });
}, { threshold: 0.1 });

document.querySelectorAll('.fade-up').forEach(el => observer.observe(el));
