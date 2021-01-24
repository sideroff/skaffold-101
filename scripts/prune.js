const { exec } = require("child_process");

const commands = [
  {
    name: "remove test files",
    value: 'find . -name "*.spec.ts" -type f -delete',
  },
];

commands.forEach((command) => {
  console.log(`--- Executing ${command.name}`);
  exec(command.value),
    (err, stdout, stderr) => {
      if (err) {
        console.log(`--- Node could not execute command ${command.name}`);
        return;
      }

      console.log(`--- ${command.name} stdout: ${stdout}`);
      console.log(`--- ${command.name} stderr: ${stderr}`);
    };
});
