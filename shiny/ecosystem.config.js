module.exports = {
  apps : [{
    script: 'app.R',
    interpreter: 'Rscript',
    cwd: '/shiny',
    watch: '.'
  }]
};
