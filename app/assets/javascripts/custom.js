document.addEventListener("DOMContentLoaded", function() {
    const buttons = document.querySelectorAll('.toggle-button');
  
    buttons.forEach(function(button) {
      button.addEventListener('click', function() {
        button.classList.toggle("bg-primary");
        button.classList.toggle("text-white");
        const target = button.dataset.target;
        const inputField = document.querySelector(`#${target}`);
        // if (inputField.style.display === 'none') {
        //   inputField.style.display = 'block';
        // } else {
        //   inputField.style.display = 'none';
        // }
        inputField.classList.toggle("d-none")
        // console.log(inputField)
      });
    });
  });
  